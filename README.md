# Vision Software Pipeline Installation Guide

This guide walks you through setting up the Vision Software Pipeline, ensuring all necessary files, directories, and configurations are properly set up for smooth operation.

## Prerequisites

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
- `path-setup.sh` - Environment path configuration (place in `~/`)
- `setup.sh` - Installation setup script (place in `~/`)
- `custom_config.py` - Custom configuration settings (place in `~/Documents/`)

### Required Directory Structure
All repositories should be placed under `~/Documents/Development/`:
```plaintext
~/Documents/Development/
├── artificial-retina-software-pipeline/
├── kilosort_convert_binary/
├── MEA/
└── npy-matlab/

~/Documents/
└── custom_config.py
```

## Installation Steps

### 1. Prepare the Required Folders

Create the Development directory if it doesn't exist:
```bash
mkdir -p ~/Documents/Development
```

### 2. Move the Additional Files

Place the configuration files in their specified locations:
```bash
# Move setup files to home directory
mv path/to/path-setup.sh ~/
mv path/to/setup.sh ~/

# Move custom config to Documents
mv path/to/custom_config.py ~/Documents/
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
   ./setup.sh
   ```

### 5. Configure Path Settings

1. **Open path-setup.sh in your preferred text editor**:
   ```bash
   # Using nano:
   nano ~/path-setup.sh

   # Or using VS Code:
   code ~/path-setup.sh
   ```

2. **Update the paths to match your system**:
   ```bash
   # Example paths that need to be updated:
   TEMPORARY_SORT_PATH="/path/to/your/data/"
   LITKE_PATH="/path/to/your/data/"
   SORTED_SPIKE_PATH="/path/to/your/data/sorted"
   KILOSORT_TTL_PATH="/path/to/your/data/sorted"
   RAW_DATA_PATH="/path/to/your/data/raw"
   ```

3. **Save the file and run it**:
   ```bash
   ./path-setup.sh
   ```

### 6. Configure run_kilosort4.py

1. **Navigate to the utilities directory**:
   
   The `run_kilosort4.py` file is located in `~/Documents/Development/MEA/src/utilities`. Open this file and ensure the following code is included before `import config as cfg`:

   ```python
   import sys
   # Get the absolute path to the directory containing your module
   module_path = os.path.expanduser('~/Documents/Development/MEA/src/analysis/config')
   # Add the module path to sys.path
   sys.path.append(module_path)
   ```

2. **Ensure the username is correct** for paths and environment setup.

### 7. Update kilosort_convert.sh

1. **Ensure Conda Python is used**:
   
   Run `which python3` in your terminal while the `kilosort` environment is active to get the path to the correct Python version. For example, it may look like:

   ```bash
   /home/kais/miniconda3/envs/kilosort/bin/python3
   ```

2. **Update kilosort_convert.sh**:
   
   Open `kilosort_convert.sh` and update line 135 to use the Python path returned by the `which python3` command. It should look like this:

   ```bash
   /home/kais/miniconda3/envs/kilosort/bin/python3 convert_litke_to_kilosort.py $litke_bin_path $kilosort2_temp_path $dsname -w -k -d $kilosort2_temp_path $is_streaming_data $start_sample_flag $start_sample_num $end_sample_flag $end_sample_num
   ```

## Important Reminders

Every time you open a terminal:
```bash
source ~/.bashrc
conda activate kilosort
```

Ensure that the username is correct when editing paths or scripts, particularly when setting paths in files like `run_kilosort4.py` and `kilosort_convert.sh`.

## Usage

1. **Navigate to the utilities directory**:
   ```bash
   cd ~/Documents/Development/MEA/src/utilities
   ```

2. **Basic Command Structure**:
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
