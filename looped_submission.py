#REMEMBER TO RUN voms-proxy-init -voms cms BEFORE THIS SCRIPT

import os
import numpy
import tempfile
import time
import random

# Generate a random number for the parquet (TAG)
parquet_number = numpy.random.randint(16801, 16961)
number_tag = str(parquet_number)

# Generate a random number between 1 and 1 billion (1e9)
random_uuid = str(random.randint(1, 10**9))

# Combine the number_tag and random_uuid to create a unique tag
unique_tag = f"{number_tag}_{random_uuid}"

# Create the temporary Python script based on the unique tag
with open('generate-data-yolo-sh.py', 'r') as file:
    content = file.read()
    modified_script_content = content.replace('TAG', unique_tag).replace('NUM', number_tag)
with open(f"{unique_tag}_temp_py.py", "w") as temp_script_file:
    temp_script_file.write(modified_script_content)
temp_script_filename = f"{unique_tag}_temp_py.py"

# Create the temporary shell script based on the unique tag
with open('data_generate_notebook.sh') as temp_sh_file:
    content = temp_sh_file.read()
    modified_content = content.replace("PY_PLACEHOLDER", temp_script_filename).replace('TAG', unique_tag)
with open(f"{unique_tag}_temp_sh.sh", "w") as file:
    file.write(modified_content)
temp_sh_filename = f"{unique_tag}_temp_sh.sh"

# Modify the submission file with the temporary script names and unique tag
with open('data_generate_job.sub', 'r') as file:
    content = file.read()
    modified_job_content = content.replace('TAG', unique_tag).replace('NUM', number_tag).replace("SCRIPT_PLACEHOLDER", temp_sh_filename).replace("PY_PLACEHOLDER", temp_script_filename)
with open(f"{unique_tag}_temp_job.sub", "w") as temp_sub_file:
    temp_sub_file.write(modified_job_content)
temp_sub_filename = f"{unique_tag}_temp_job.sub"

# Submit the job using condor_submit
os.system(f'condor_submit {temp_sub_filename}')

# Optional: Clean up the temporary files
#os.remove(temp_sub_filename)
#os.remove(temp_script_filename)

# Print submission confirmation
print(f'submitted job called {temp_sub_filename}')


