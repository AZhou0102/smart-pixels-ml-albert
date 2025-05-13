# Workflow
(All data is stored in https://cernbox.cern.ch/files/spaces/eos/project/s/smartpix-box/pixelAV_datasets)

### `looped_submission.py`
- Will rename all NUM and TAG variables for a single submission  
- Ensures “unique-ness” with a randomly generated number  
- Will generate temporary `.sub`, `.sh`, and `.py` files  
- Submits the `temp_job.sub`

---

### `data_generate_job.sub` (e.g., `16932_898219640_temp_job.sub`)
- Submits the job  
- Outputs the `.tar.gz` file  
- Calls `data_generate_notebook.sh`

---

### `data_generate_notebook.sh` (e.g., `16932_898219640_temp_sh.sh`)
- Calls the Python script  
- After the Python runs, feeds the directories into the proper structure to tar (ON TRAIN RIGHT NOW)  
- Tars everything and gets it ready for output

---

### `generate-data-yolo-sh.py` (e.g., `16932_898219640_temp_py.py`)
- Generates the data  
- At the bottom, set the parameter for how many files to generate at a time  
  **(don’t go over 20,000 since jobs are killed after 2 days)**

---

### `watch_and_move_to_eos.py`
- Runs in background and periodically moves any `.tar.gz` files it finds in:
