# Vision Software Pipeline Installation Guide

This guide walks you through setting up the Vision Software Pipeline, ensuring all necessary files, directories, and configurations are properly set up for smooth operation.

## Prerequisites

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
- `custom_config.py` - Custom configuration settings (place in data directory)

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
Note: Change username ('kais') in all paths to match your system.

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

For Conda installation, follow the official guide:
[Miniconda Installation Instructions](https://docs.anaconda.com/miniconda/install/)

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
   chmod +x setup.sh
   ```

### 5. Configure Path Settings

1. **Open path-setup.sh in your preferred text editor**:
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
   Note: Change username ('kais') in all paths to match your system.
   ```

3. **Save and run the file**:
   ```bash
   ./path-setup.sh
   ```

   Note: If you get a permission error:
   ```bash
   chmod +x path-setup.sh
   ```

## Usage

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
   chmod +x script.sh
   ```

2. **Conda Environment Not Found**
   ```bash
   conda: command not found
   ```
   Solution: Initialize conda or check installation
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

4. **Path Configuration Issues**
   - Check if all paths in custom_config.py exist
   - Verify permissions on data directories
   - Ensure .bashrc is properly sourced

5. **Common File Permission Issues**
   ```bash
   mkdir: cannot create directory: Permission denied
   ```
   Solution: Check directory permissions or use sudo
   ```bash
   ls -la /path/to/directory
   sudo chown -R $USER:$USER /path/to/directory
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
