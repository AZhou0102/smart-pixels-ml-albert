#!/bin/bash
# Activate environment (if needed)
#add the tar-zxvf line and change the path
tar -zxvf ./myenv.tar.gz
source ./myenv/bin/activate

# Run the Python script generated from the Jupyter notebook
python generate-data-yolo-sh.py

# Deactivate environment
deactivate
