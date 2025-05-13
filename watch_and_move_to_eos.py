import time
from pathlib import Path
import shutil
import os

# Config
eos_path = "/eos/uscms/store/user/azhou/htcondor_outputs"
watch_dir = Path(".")  # or specify another path
poll_interval = 5     # seconds

print(f"👀 Watching for .tar.gz files to move to {eos_path}...")

while True:
    tarballs = list(watch_dir.glob("*_output*.tar.gz"))
    for tarball in tarballs:
        eos_target = Path(eos_path) / tarball.name
        if eos_target.exists():
            print(f"✅ {tarball.name} already exists in EOS. Skipping.")
            continue
        try:
            print(f"📦 Moving {tarball.name} → {eos_target}")
            shutil.move(str(tarball), str(eos_target))
        except Exception as e:
            print(f"❌ Error moving {tarball.name}: {e}")
    
    time.sleep(poll_interval)
