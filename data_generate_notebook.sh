#!/bin/bash
# Activate environment (if needed)
#add the tar-zxvf line and change the path
ls -l

source /usr/local/etc/profile.d/conda.sh

conda activate myenv



# Create a root directory for the job output (keeping the structure)

mkdir -p ./TAG/valid/images
mkdir -p ./TAG/valid/labels
mkdir -p ./TAG/valid/df

python PY_PLACEHOLDER

# Move the generated files into their respective subdirectories
mv TAG_generated_images/* ./TAG/valid/images/
mv TAG_generated_labels/* ./TAG/valid/labels/
mv TAG_generated_df/* ./TAG/valid/df/


# Create tarball with the root structure (train/images, train/labels, train/df)
tarball_name="valid_TAG_output.tar.gz"
tar -czf "$tarball_name" -C ./TAG valid

#Cannot  Move tarball to EOS (mounted path)
#eos_path="/eos/uscms/store/user/azhou/htcondor_outputs"
#mkdir -p "$eos_path"
#mv "$tarball_name" "$eos_path/"

# Deactivate environment
conda deactivate
