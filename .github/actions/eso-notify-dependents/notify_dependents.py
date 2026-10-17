import json
import os
import re
import sys
import urllib.error
import urllib.parse
import urllib.request

API = 'https://api.github.com'


def call(method, url, token, body=None):
    headers = {'Accept': 'application/vnd.github+json', 'User-Agent': 'eso-notify-dependents',
               'X-GitHub-Api-Version': '2022-11-28', 'Authorization': 'Bearer ' + token}
    data = json.dumps(body).encode('utf-8') if body is not None else None
    if data is not None:
        headers['Content-Type'] = 'application/json'
    with urllib.request.urlopen(urllib.request.Request(url, data=data, headers=headers, method=method), timeout=30) as response:
        text = response.read().decode('utf-8', 'replace')
        return json.loads(text) if text.strip() else None


def owned_repos(owner, token):
    repos, page = [], 1
    while True:
        batch = call('GET', '%s/user/repos?affiliation=owner&per_page=100&page=%d' % (API, page), token) or []
        repos += [r for r in batch if r.get('owner', {}).get('login', '').lower() == owner.lower()]
        if len(batch) < 100:
            return repos
        page += 1


def has_marker(repo, marker, token):
    try:
        call('GET', '%s/repos/%s/contents/%s?ref=%s' % (API, repo['full_name'], urllib.parse.quote(marker), urllib.parse.quote(repo['default_branch'])), token)
        return True
    except urllib.error.HTTPError as err:
        if err.code == 404:
            return False
        raise


def summary(lines):
    path = os.environ.get('GITHUB_STEP_SUMMARY')
    if path:
        with open(path, 'a', encoding='utf-8') as handle:
            handle.write('\n'.join(lines) + '\n')


def main():
    token = os.environ.get('DISPATCH_TOKEN', '')
    source = os.environ.get('SOURCE_REPO', '')
    owner = source.split('/')[0]
    stem = re.sub(r'\.ya?ml$', '', os.path.basename(os.environ.get('SOURCE_WORKFLOW', '')))
    marker = os.environ.get('MARKER', '')
    event_type = '%s-%s' % (source.split('/')[-1].lower(), stem)
    if not token:
        print('::notice title=Dependents not notified::No dispatch token is set, so the add-ons that follow %s run on their own schedule.' % source)
        summary(['## Dependents not notified', '', 'No dispatch token is set; the add-ons run on their own schedule.'])
        return 0
    if not stem:
        print('::warning title=No source workflow::Nothing says which workflow finished; no one was notified.')
        return 0
    try:
        repos = [r for r in owned_repos(owner, token) if r['full_name'].lower() != source.lower() and not r.get('archived') and not r.get('fork')]
    except urllib.error.HTTPError as err:
        print('::warning title=Could not list repositories::%s. The add-ons run on their own schedule.' % err)
        return 0
    sent, failed = [], []
    for repo in sorted(repos, key=lambda r: r['full_name'].lower()):
        try:
            if not has_marker(repo, marker, token):
                continue
            if os.environ.get('DRY_RUN', '') != 'true':
                call('POST', '%s/repos/%s/dispatches' % (API, repo['full_name']), token,
                     {'event_type': event_type, 'client_payload': {'from': source, 'workflow': stem}})
            sent.append(repo['full_name'])
        except urllib.error.HTTPError as err:
            failed.append('%s (%s)' % (repo['full_name'], err.code))
    verb = 'Would send' if os.environ.get('DRY_RUN', '') == 'true' else 'Sent'
    print('%s %s to %d repositories: %s' % (verb, event_type, len(sent), ', '.join(sent) or 'none'))
    lines = ['## %s `%s`' % (verb, event_type), ''] + ['- %s' % name for name in sent]
    if failed:
        print('::warning title=Some dispatches failed::%s. Those add-ons run on their own schedule.' % ', '.join(failed))
        lines += ['', 'Failed: ' + ', '.join(failed)]
    summary(lines)
    return 0


if __name__ == '__main__':
    sys.exit(main())
