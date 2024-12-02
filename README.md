# Vision Software Pipeline Installation Guide

This guide will walk you through the steps required to set up and install the Vision Software Pipeline, ensuring all the necessary files, directories, and configurations are properly set up for smooth operation.

---

## **Reminder***

- **Every time you open a terminal, make sure to run:**
  
  ```bash
  source ~/.bashrc
  conda activate kilosort
  ```

- **Ensure that the username is correct when editing paths or scripts, particularly when setting paths in files like `run_kilosort4.py` and `kilosort_convert.sh`.**

---

## Prerequisites

Before starting the installation, ensure you have the following folders and files available:

### Required Folders
- **artificial-retina-software-pipeline**
- **kilosort_convert_binary**
- **MEA**

### Additional Files
- **path-setup.sh**  
- **setup.sh**  
- **custom_config.py**

---

## Installation Steps

### 1. Prepare the Required Folders

Ensure the necessary folders are placed under the `~/Documents/Development/` directory. If the `Development` directory does not exist, create it:

```bash
mkdir -p ~/Documents/Development
```

Then, place the required folders inside the `Development` directory:

```bash
mv path/to/artificial-retina-software-pipeline ~/Documents/Development/
mv path/to/kilosort_convert_binary ~/Documents/Development/
mv path/to/MEA ~/Documents/Development/
```

The directory structure should look like this:

```bash
~/Documents/Development/
  ├── artificial-retina-software-pipeline/
  ├── kilosort_convert_binary/
  └── MEA
```

---

### 2. Move the Additional Files

Move the necessary configuration files to their specified locations:

- **Move `path-setup.sh` to the home directory (`~/`)**:

  ```bash
  mv path/to/path-setup.sh ~/
  ```

- **Move `setup.sh` to the home directory (`~/`)**:

  ```bash
  mv path/to/setup.sh ~/
  ```

- **Move `custom_config.py` to the `config` folder within the `MEA` directory**:

  ```bash
  mv path/to/custom_config.py ~/Documents/
  ```

---

### 3. Install Conda

If Conda is not already installed, follow these steps to install it:

#### Check if Conda is Installed:

```bash
conda --version
```

#### If Conda is not installed, install Miniconda:

1. **Download Miniconda**:
   - For Linux:
     ```bash
     wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
     ```
   - For MacOS:
     ```bash
     wget https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -O ~/miniconda.sh
     ```

2. **Install Miniconda**:
   ```bash
   bash ~/miniconda.sh -b -p $HOME/miniconda
   ```

3. **Initialize Conda**:
   ```bash
   source ~/miniconda/bin/activate
   conda init
   ```

---

### 4. Create the `kilosort` Conda Environment

1. **Navigate to the `MEA/hyak/containers/` directory**:
   
   This path might vary depending on your current location in the terminal, but the general location is:

   ```bash
   cd ~/Documents/Development/MEA/hyak/containers/
   ```

2. **Install the Conda environment using the provided `kilosort.yml` file**:
   
   ```bash
   conda env create -f kilosort.yml
   ```

3. **Activate the `kilosort` environment**:
   
   Once the environment is created, activate it with:

   ```bash
   conda activate kilosort
   ```

---

### 5. Run `path-setup.sh`

Now that your Conda environment is active, run the `path-setup.sh` script to configure the necessary paths.

1. **Navigate to your home directory**:
   ```bash
   cd ~
   ```

2. **Run the `path-setup.sh` script**:
   ```bash
   ./path-setup.sh
   ```

   After running the script, the output should display the paths set for the environment, for example:

   ```bash
   TEMPORARY_SORT_PATH = /media/kais/Kais/data/
   LITKE_PATH = /media/kais/Kais/data/
   SORTED_SPIKE_PATH = /media/kais/Kais/data/sorted
   KILOSORT_TTL_PATH = /media/kais/Kais/data/sorted
   RAW_DATA_PATH = /media/kais/Kais/data/raw
   VISIONPATH = /home/kais/Documents/Development/MEA/src/Vision7_for_2015DAQ/Vision.jar
   LAB_NAME = Field
   ```

   The output also includes Python paths to confirm correct configuration, such as:

   ```bash
   /home/kais/Documents/Development/kilosort_convert_binary
   /home/kais/Documents/Development/artificial-retina-software-pipeline/utilities
   /home/kais/Documents/Development/artificial-retina-software-pipeline/utilities/bin2py
   /home/kais/Documents/Development/artificial-retina-software-pipeline/utilities/bin2py/cython_extensions
   ```

---

### 6. Configure `run_kilosort4.py`

1. **Navigate to the `utilities` directory**:

   The `run_kilosort4.py` file is located in `~/Documents/Development/MEA/src/utilities`. Open this file and ensure the following code is included before `import config as cfg`:

   ```python
   import sys
   # Get the absolute path to the directory containing your module
   module_path = os.path.expanduser('~/Documents/Development/MEA/src/analysis/config')
   # Add the module path to sys.path
   sys.path.append(module_path)
   ```

2. **Ensure the username is correct** for paths and environment setup.

---

### 7. Update `kilosort_convert.sh`

1. **Ensure Conda Python is used**:
   
   Run `which python3` in your terminal while the `kilosort` environment is active to get the path to the correct Python version. For example, it may look like:

   ```bash
   /home/kais/miniconda3/envs/kilosort/bin/python3
   ```

2. **Update `kilosort_convert.sh`**:
   
   Open `kilosort_convert.sh` and update line 135 to use the Python path returned by the `which python3` command. It should look like this:

   ```bash
   /home/kais/miniconda3/envs/kilosort/bin/python3 convert_litke_to_kilosort.py $litke_bin_path $kilosort2_temp_path $dsname -w -k -d $kilosort2_temp_path $is_streaming_data $start_sample_flag $start_sample_num $end_sample_flag $end_sample_num
   ```

---

## Final Steps Reminder

- **Every time you open a terminal, make sure to run:**
  
  ```bash
  source ~/.bashrc
  conda activate kilosort
  ```

- **Ensure that the username is correct when editing paths or scripts, particularly when setting paths in files like `run_kilosort4.py` and `kilosort_convert.sh`.**

--- 

With these steps complete, your Vision Software Pipeline should be fully set up and ready for use.
