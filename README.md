Workflow

looped_submission.py 
• Will rename all NUM and TAG variables for a single submission
• Ensures “unique-ness” with a randomly generated number
• Will generate temporary .sub, .sh, and .sub files
• Submits the temp_job.sub

data_generate_job.sub (16932_898219640_temp_job.sub)
• Submits the job
• Outputs the tar.gz file
• Calls data_generate_notebook.sh

data_generate_notebook.sh (16932_898219640_temp_sh.sh)
• Calls the python 
• After the python, feeds the directories into the proper structure to tar (ON TRAIN RIGHT NOW)
• Tars everything and ready for output

generate-data-yolo-sh.py (16932_898219640_temp_py.py)
• Generates the data
• At the bottom, parameter for how many files to generate at a time (don’t go over 20,000 since jobs are killed after 2 days)

watch_and_move_to_eos.py
• Runs in background and periodically moves any .tar.gz files it finds in /uscms/home/azhou/nobackup/condor_stuff to the eos: /eos/uscms/store/user/azhou/htcondor_outputs
