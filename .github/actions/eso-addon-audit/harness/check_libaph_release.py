import os, re, sys, glob
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import audit_env

ROOT = audit_env.projects_root()
BACKUP = os.path.join(audit_env.workspace_root(), "#GITHUB-BACKUP")
copies = sorted(glob.glob(os.path.join(BACKUP, "*", "LibAPH-main", "LibAPH.addon")))
local = os.path.join(ROOT, "LibAPH", "LibAPH.addon")
if not copies or not os.path.isfile(local):
    print("LIBAPH RELEASE CHECK OK: no GitHub backup of LibAPH here, the release workflows' dependency check covers it")
    sys.exit(0)


def field(text, name):
    m = re.search(r"^## %s:\s*(\S+)" % name, text, re.M)
    return m.group(1) if m else None


released = open(copies[-1], encoding="utf-8").read()
rv, ra = field(released, "Version"), field(released, "AddOnVersion")
mine = open(local, encoding="utf-8").read()
bad = []
if field(mine, "Version") != rv or field(mine, "AddOnVersion") != ra:
    bad.append("LibAPH/LibAPH.addon says %s / %s but the released LibAPH (%s) is %s / %s. LibAPH's version only changes when it is released"
               % (field(mine, "Version"), field(mine, "AddOnVersion"), os.path.relpath(copies[-1], BACKUP), rv, ra))
for path in sorted(glob.glob(os.path.join(ROOT, "*", "*.addon")) + glob.glob(os.path.join(ROOT, "*", "*.txt"))):
    if "(Copy)" in path or not os.path.isfile(path):
        continue
    m = re.search(r"LibAPH>=(\d+)", open(path, encoding="utf-8", errors="replace").read())
    if m and int(m.group(1)) > int(ra):
        bad.append("%s requires LibAPH>=%s, above the released %s; the game would refuse to load it" % (os.path.relpath(path, ROOT), m.group(1), ra))

if bad:
    print("LIBAPH RELEASE CHECK FAILED")
    for entry in bad:
        print("  " + entry)
    sys.exit(1)
print("LIBAPH RELEASE CHECK OK: LibAPH stays at its released %s (%s) and no add-on requires more" % (rv, ra))
