import json, subprocess, sys, pathlib

out = subprocess.run(["terraform", "-chdir=terraform", "output", "-json", "instance_ips"],
                     capture_output=True, text=True, check=True).stdout
ips = json.loads(out)  # {"app": "172.17.0.x", "db": "172.17.0.y"}

lines = []
for role, ip in ips.items():
    lines.append(f"[{role}]\n{ip}\n")
lines.append("[all:vars]\nansible_user=root\n")

path = pathlib.Path("ansible/inventory/hosts.ini")
path.parent.mkdir(parents=True, exist_ok=True)
path.write_text("\n".join(lines), encoding="utf-8")
print(path.read_text())