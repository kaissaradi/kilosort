# Vision Software Pipeline Installation Guide

This guide walks you through setting up the Vision Software Pipeline, ensuring all necessary files, directories, and configurations are properly set up for smooth operation.

---

## Prerequisites

### Conda Setup
For Conda installation, follow the official guide:  
[Miniconda Installation Instructions](https://docs.anaconda.com/miniconda/install/)

### Windows Setup (If Applicable)
If you're using Windows, you'll need Windows Subsystem for Linux (WSL):
1. Open PowerShell as Administrator and run: `wsl --install`
2. Install Ubuntu 22.04 LTS from Microsoft Store
3. For detailed setup: [Microsoft WSL Installation Guide](https://learn.microsoft.com/en-us/windows/wsl/install)

### System Requirements
- CUDA Toolkit (11.0 or later)
  ```bash
  # Check CUDA installation
  nvcc --version
  
  # If not installed (Ubuntu/Debian):
  sudo apt update
  sudo apt install nvidia-cuda-toolkit

  # For other operating systems, visit:
  # https://developer.nvidia.com/cuda-downloads
  ```

### Required Repositories
- [MEA](https://github.com/mikemanookin/MEA) - Core MEA analysis tools
- [npy-matlab](https://github.com/kwikteam/npy-matlab) - MATLAB-Python interface utilities
- `kilosort_convert_binary` - Conversion utilities for Kilosort
- `artificial-retina-software-pipeline` - Core pipeline tools

### Required Configuration Files
These files should be obtained from their respective repositories:
- `.bashrc` - Optionally copy from GitHub repository
- `path-setup.sh` - Environment path configuration (place in `~/`)
- `setup.sh` - Installation setup script (place in `~/`)
- `custom_config.py` - Custom configuration settings (place in the data directory)

Example `path-setup.sh` structure:
```bash
# Paths for analysis pipeline.
variables=(
    'export TEMPORARY_SORT_PATH=/media/kais/Kais/data/'
    'export LITKE_PATH=/media/kais/Kais/data/'
    'export SORTED_SPIKE_PATH=/media/kais/Kais/data/sorted'
    'export KILOSORT_TTL_PATH=/media/kais/Kais/data/sorted'
    'export RAW_DATA_PATH=/media/kais/Kais/data/raw'
    'export VISIONPATH=/home/kais/Documents/Development/MEA/src/Vision7_for_2015DAQ/Vision.jar'
    'export LAB_NAME=Field'
)
```
Note: Change the username (`kais`) in all paths to match your system.

In `custom_config.py`, update line 3 to match your data path:
```python
DATA_VOLUME = '/mnt/FieldLab/Array-data/'  # Change to match your data path
```

### Required Directory Structure
All repositories should be placed under `~/Documents/Development/`:
```plaintext
~/Documents/Development/
├── artificial-retina-software-pipeline/
├── kilosort_convert_binary/
├── MEA/
└── npy-matlab/

/path/to/data/          # Create manually or copy structure from GitHub
├── raw/           # Raw data in YYYYMMDD[A-Z] format
├── metadata/      
│   └── json/     
├── h5/           # H5 files (same name as raw data folder)
└── sorted/       # Auto-populated by scripts
```

---

## Installation Steps

### 1. Prepare the Required Folders
Create the Development directory if it doesn't exist:
```bash
mkdir -p ~/Documents/Development
```

### 2. Copy Configuration Files

1. Copy `.bashrc` from the repository:
   ```bash
   cp path/to/repo/.bashrc ~/
   ```

2. Place other configuration files:
   ```bash
   # Move setup files to home directory
   mv path/to/path-setup.sh ~/ 
   mv path/to/setup.sh ~/ 

   # Move custom config to data directory
   mv path/to/custom_config.py /path/to/your/data/
   ```

### 3. Install Conda
If Conda is not already installed:

1. **Check if Conda is installed**:
   ```bash
   conda --version
   ```

2. **If not installed, install Miniconda**:
   ```bash
   # For Linux:
   wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
   # For MacOS:
   wget https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -O ~/miniconda.sh
   ```

3. **Install and initialize**:
   ```bash
   bash ~/miniconda.sh -b -p $HOME/miniconda
   source ~/miniconda/bin/activate
   conda init
   ```

### 4. Create the Kilosort Environment

1. **Navigate to your home directory**:
   ```bash
   cd ~
   ```

2. **Run the setup script**:
   ```bash
   source setup.sh
   ```

   Note: If you get a permission error, make the script executable:
   ```bash
   sudo chmod +x setup.sh
   ```

### 5. Configure Path Settings

1. **Open `path-setup.sh` in your preferred text editor**:
   ```bash
   nano ~/path-setup.sh
   ```

2. **Update the paths to match your system**:
   ```bash
   # Paths for analysis pipeline.
   variables=(
       'export TEMPORARY_SORT_PATH=/media/kais/Kais/data/'
       'export LITKE_PATH=/media/kais/Kais/data/'
       'export SORTED_SPIKE_PATH=/media/kais/Kais/data/sorted'
       'export KILOSORT_TTL_PATH=/media/kais/Kais/data/sorted'
       'export RAW_DATA_PATH=/media/kais/Kais/data/raw'
       'export VISIONPATH=/home/kais/Documents/Development/MEA/src/Vision7_for_2015DAQ/Vision.jar'
       'export LAB_NAME=Field'
   )
   ```

   Note: Change the username (`kais`) in all paths to match your system.

3. **Save and run the file**:
   ```bash
   ./path-setup.sh
   ```

   Note: If you get a permission error:
   ```bash
   sudo chmod +x path-setup.sh
   ```

### 6. Configure `run_kilosort4.py`

1. **Navigate to the utilities directory**:
   ```bash
   cd ~/Documents/Development/MEA/src/utilities
   ```

2. **Modify the file to include the module path**:
   Open `run_kilosort4.py` and ensure the following code is included before `import config as cfg`:
   ```python
   import sys
   # Get the absolute path to the directory containing your module
   module_path = os.path.expanduser('~/Documents/Development/MEA/src/analysis/config')
   # Add the module path to sys.path
   sys.path.append(module_path)
   ```

### 7. Install Kilosort 2.5
Follow the detailed installation guide for Kilosort 2.5 here:  
[Kilosort 2.5 Installation Guide](https://github.com/kaissaradi/kilosort/blob/main/kilosort2.md)

This guide includes:
- Required MATLAB toolboxes
- GPU compatibility check
- CUDA configuration
- Troubleshooting steps

---

## Usage

The files for running the kilosort pipline can be found by going to the utilities folder in the MEA repo:
```bash
cd ~\Documents\Development\MEA\src\utilities
```
and then running the pipeline.sh script. This file is also where you will want to look first when debugging. This script will set all the paths, parse the h5 files, converts the bin files if needed, then run kilosort 2.4 or 4 depending on the usage, and finally post-process and save the data.
run_kilosort4.py will set all the parameters and then call the run_kilosort function from run_kilosort.py which can be found in: `~\miniconda3\envs\kilosort\lib\python3.9\site-packages\kilosort`. If using kilosort2.5, the run_kilosort2.5m file will be called isntead, setup for previous versions can be found here:
[Kilosort 2.5 Installation Guide](https://github.com/kaissaradi/kilosort/blob/main/kilosort2.md)

1. **Basic Command Structure**:
   ```bash
   pipeline.sh <EXPERIMENT_DATE> <CHUNK_NAME> -f <DATA_FILES> -e <EI_FILES> -n <NOISE_FILES> -a <ARRAY_SPACING> -p <PROTOCOL>
   ```

### Examples

#### Single File Processing
```bash
bash pipeline.sh 20240820A chunk10 -f "data010" -n "data010" -e "data010" -a 30 -s "4"
```

#### Multiple File Processing
```bash
bash pipeline.sh 20240926C chunk1 -f "data000 data001 data002" -e "data000" -n "data000" -a 120 -p "SpatialNoise"
```

## Troubleshooting

### Common Issues

1. **Permission Denied Errors**
   ```bash
   -bash: ./script.sh: Permission denied
   ```
   Solution: Make the script executable
   ```bash
   sudo chmod +x script.sh
   ```

2. **Conda Environment Not Found**
   ```bash
   conda: command not found
   ```
   Solution: Initialize conda or check installation, it may need to be reinstalled
   ```bash
   source ~/miniconda3/bin/activate
   conda init
   ```

3. **CUDA Not Found**
   ```bash
   nvcc: command not found
   ```
   Solution: Install CUDA toolkit or check PATH
   ```bash
   echo $PATH | grep cuda
   ```
   ```bash
   sudo apt install nvidia-cuda-toolkit
   ```

4. **Path Configuration Issues**
   common error will be `H5 file path/to/data/h5file.h5 not found. Cannot continue.`
   
   - Check all paths in custom_config.py, and .bashrc
   - Ensure .bashrc is properly sourced by running:
   ```bash
   source ~/.bashrc
   ```
   - CHECK FOR TRAILING OR MISSING "/" IN THE OUTPUT AND ENSURE ALL TRAILING "/"'s MATCH THE TEMPLATE
   
   ```bash
   cat ~/.bashrc
   ```
6. **Kilosort Parameter Count Error**
When you encounter:
```
TypeError: function takes 8 positional arguments but 9 were given
```
This occurs when using the development version of kilosort4 which exlcudes the kept_spikes parameter
You can delete this parameter in line 185 of run_kilosort4.py found in `~\Documents\Development\MEA\src\utilities`
Solution: Reinstall Kilosort with GUI support:
```bash
pip uninstall kilosort
pip install kilosort[gui]
```

6. **Custom Config Module Not Found**
When you encounter:
```
ModuleNotFoundError: No module named 'custom_config'
```

Solution: Ensure custom_config.py is in both:
```bash
~/Documents/
~/Documents/Development/MEA/src/analysis/config
```
This redundancy can help prevent issues. Make sure both copies have your correct data path settings.

  ensure that the bashrc has the necessary export lines with the correct paths, and has set the necessary PYTHONPATHs. The contents of the bashrc file should end these (unless you added anything after or installed conda after):

  ```
     # Paths for analysis pipeline.
  export TEMPORARY_SORT_PATH='/mnt/FieldLab/Array-data'
  export LITKE_PATH='/mnt/FieldLab/Array-data/'
  export SORTED_SPIKE_PATH='/mnt/FieldLab/Array-data/sorted'
  export KILOSORT_TTL_PATH='/data/data/sorted'
  export RAW_DATA_PATH='/mnt/FieldLab/Array-data/raw'
  export VISIONPATH='/home/kais/Documents/Development/MEA/src/Vision7_for_2015DAQ/Vision.jar'
  export LAB_NAME='Field' # Your lab name goes here.
  export PYTHONPATH=$PYTHONPATH:/home/kais/miniconda3/bin/python3
  export PATH=$PATH:/usr/local/MATLAB/R2024b/bin
  export PYTHONPATH=$PYTHONPATH:/home/kais/anaconda3/envs/kilosort/bin/python3
  export PYTHONPATH=$PYTHONPATH:/home/kais/kilosort_convert_binary
  export PYTHONPATH=$PYTHONPATH:/home/kais/artificial-retina-software-pipeline/utilities
  export PYTHONPATH=$PYTHONPATH:/home/kais/artificial-retina-software-pipeline/utilities/bin2py
  export PYTHONPATH=$PYTHONPATH:/home/kais/artificial-retina-software-pipeline/utilities/bin2py/cython_extensions
  export PYTHONPATH=$PYTHONPATH:/home/kais/artificial-retina-software-pipeline/utilities/visionwriter
  export PYTHONPATH=$PYTHONPATH:/home/kais/artificial-retina-software-pipeline/utilities/visionwriter/cython_extensions
  export PYTHONPATH=$PYTHONPATH:/home/kais/artificial-retina-software-pipeline/utilities/lib
  ```
   

7. CUDA Device Memory Error
When you encounter this error:
```bash
RuntimeError: Unexpected error from cudaGetDeviceCount(). Did you run some cuda functions before calling NumCudaDevices() that might have already set an error? Error 2: out of memory
```

You can diagnose it by running:
```bash
python
```
then:
```python
import torch
torch.cuda.init()
```

This is confirmed if torch.cuda.init() returns nothing or an error. This error seems to occur with multiple GPUs in WSL environment. The solution is to limit visible CUDA devices by running:
```bash
export CUDA_VISIBLE_DEVICES=0,1,2  # Use first three GPUs
```
Or
```bash
export CUDA_VISIBLE_DEVICES=0,1    # Use first two GPUs
```
OR
```bash
export CUDA_VISIBLE_DEVICES=0      # Use only first GPU
```
*NOTE* This command will have to run everytime you open a new shell, to keep this change add this line to bashrc in `~/.bashrc`

8. 'Number of Channels' error:

If you receive this error or similar: 
![image](https://github.com/user-attachments/assets/84860cc6-7354-4d06-932c-759399b87cf2)

Check the array spacing (can be 30 or 60 microns depending on the array used), also double check the number of channels is 512.

9. GPU out of Memory

Kilosort4 is a particularly intensive operation, and large data sets can lead to errors with running out of GPU memory:

**SHOW ERROR**

to fix this, the best solution so far is to change the batch size in the call to run_kilosort4.py, found in line 246 and line 248 of pipline.sh in `~/Documents/Development/MEA/src/utilities`
add the flag for batch size (-b), the default size is 60000, using 30000 or even 10000 for particularly large data sets will allow you to process them (keep in mind this does slow down the pipeline somewhat)
this 
```python
          python run_kilosort4.py ${EXP} ${CHUNK} -e ${ARRAY_SPACING} -c
        else
          python run_kilosort4.py ${EXP} ${CHUNK} -e ${ARRAY_SPACING}
```
should be changed to 
```python
          python run_kilosort4.py ${EXP} ${CHUNK} -e ${ARRAY_SPACING} -c -b 10000 # add the -b flag followed by batch size < 60000
        else
          python run_kilosort4.py ${EXP} ${CHUNK} -e ${ARRAY_SPACING} -b 10000 # add the -b flag followed by batch size < 60000
```


### Pipeline Parameters

#### Required Arguments
- `<EXPERIMENT_DATE>`: Recording date (e.g., `20240820A`)
- `<CHUNK_NAME>`: Chunk identifier (e.g., `chunk1`)

#### Optional Flags
```plaintext
-e, --ei_files      The EI files to use for deduplication
-f, --chunk_files   The chunk files to process (can be space-separated for multiple files)
-n, --noise_files   The noise files to use for RF calculation
-a, --array_spacing The array spacing to use for RF calculation
-c, --use_car       Use common average reference
-p, --protocol      The protocol to use for RF calculation (e.g., 'SpatialNoise')
-s, --sort_algorithms The sorting algorithms to use
-t, --threads       The number of threads to use for processing
```
