mkdir -p /mnt/dataset_mounts /mnt/combined_dataset

#!/bin/bash
set -e

MOUNT_DIR="$HOME/dataset_mounts"

echo "[INFO] Creating the mount directory..."
mkdir -p "$MOUNT_DIR"
mkdir -p "$HOME/combined_dataset"

echo "[INFO] Mounting all tarballs..."
for f in /datasets/*.tar.gz; do
    name=$(basename "$f" .tar.gz)
    mkdir -p "$MOUNT_DIR/$name"
    archivemount "$f" "$MOUNT_DIR/$name"
done

#fuse
echo "[INFO] Fusing mounted directories..."
MOUNT_POINTS=$(find "$MOUNT_DIR" -mindepth 1 -maxdepth 1 -type d | sed 's/$/=RO/')
UNION_STRING=$(echo "$MOUNT_POINTS" | tr '\n' ':' | sed 's/:$//')

unionfs-fuse "$UNION_STRING" "$HOME/combined_dataset"

echo "[INFO] UnionFS mount created at $HOME/combined_dataset"

