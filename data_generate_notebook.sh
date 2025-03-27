#!/bin/bash
# Activate environment (if needed)
#add the tar-zxvf line and change the path

echo "Extracting myenv.tar.gz..."
tar -zxvf ./newenv.tar.gz

# Verify that the environment exists
if [ ! -d "newenv/newenv/bin" ]; then
    echo "Error: /newenv is not a valid Conda environment."
    exit 1
fi

source /usr/local/etc/profile.d/conda.sh

conda --version
echo "Conda is located at: $(which conda)"

echo "Verify Conda's Environment Directory Configuration"
conda config --show envs_dirs
conda config --add envs_dirs /newenv/newenv
conda config --add envs_dirs /newenv
conda config --show envs_dirs

echo "Activating Conda environment..."
#conda activate myenv || { echo "Failed to activate Conda environment"; exit 1; }
source /newenv/newenv/bin/activate || { echo "Failed to activate Conda environment"}
conda activate newenv
conda activate newenv/newenv/
echo "Adding /myenv to Conda's environment directories..."
conda config --add envs_dirs /newenv

# Verify Python and environment
echo "Python executable being used: $(which python)"
echo "Python version: $(python --version)"

echo "Activated Conda environment: $(conda info --envs)"

mkdir -p ./generated_labels
mkdir -p ./generated_df
mkdir -p ./generated_images

python generate-data-yolo-sh.py

# Deactivate environment
conda deactivate

echo "First file in generated_labels:"
ls -l ./generated_labels | head -n 1
