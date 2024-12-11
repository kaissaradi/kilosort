# Kilosort 2.5 Installation Guide

## 1. Download and Setup

1. **Download Kilosort**
   - Download Kilosort 2.5 from: https://github.com/MouseLand/Kilosort/releases/tag/v2.5.2
   - Place it in the Development directory:
     ```bash
     mv path/to/downloaded/kilosort2.5 ~/Documents/Development/
     ```

## 2. Install Required MATLAB Toolboxes

1. **Open Add-On Explorer in MATLAB**
   - Click on the "Home" tab in MATLAB
   - Click on "Add-Ons" button
   - Select "Get Add-Ons" from the dropdown menu

2. **Install Required Toolboxes**
   
   Search for and install each of these toolboxes:
   - Parallel Computing Toolbox
   - Signal Processing Toolbox
   - DSP System Toolbox

   For each toolbox:
   1. Type the toolbox name in the search bar
   2. Click on the toolbox from the search results
   3. Click "Install"
   4. Follow the installation prompts

## 3. Validate MATLAB GPU Support

1. **Check GPU Compatibility**

   If using MATLAB 2024b:
   ```matlab
   validateGPU
   ```
   All tests should show as "PASSED".

   For older MATLAB versions, check compatibility requirements here:
   https://www.mathworks.com/help/parallel-computing/gpu-computing-requirements.html

## 4. Configure CUDA Support

1. **Navigate to CUDA Directory**
   ```matlab
   cd ~/Documents/Development/Kilosort2.5/Kilosort2.5/CUDA
   ```

2. **Run the MEX Setup**
   
   You can run the script in two ways:

   Option 1: From terminal:
   ```bash
   matlab mexGPUall.m
   ```

   Option 2: From within MATLAB:
   - Open MATLAB
   - Click the "Open" button in the toolbar
   - Navigate to `~/Documents/Development/Kilosort2.5/Kilosort2.5/CUDA`
   - Select `mexGPUall.m` and click "Open"
   - Click the "Run" button (green play button) in the editor toolbar

   You should see several "Building with 'NVIDIA CUDA compiler'" and "MEX completed successfully" messages.

### Troubleshooting Compiler Errors

If you encounter compiler errors, try these solutions:

1. **Install GCC 11**
   ```bash
   sudo apt install gcc-11 g++-11
   sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 60 --slave /usr/bin/g++ g++ /usr/bin/g++-11
   ```

2. **Check MATLAB Configuration**
   - Type `gpuDevice` to check versions used by MATLAB
   - On Windows, use `mex --setup` to list and select compatible compilers

## 5. Configure run_kilosort.m Paths

1. **Open run_kilosort.m**
   - Launch MATLAB
   - Click the "Open" button in the toolbar
   - Navigate to `~/Documents/Development/MEA/src/utilities`
   - Select `run_kilosort.m` and click "Open"

2. **Update Repository Paths (Lines 94-95)**

   Change FROM:
   ```matlab
   addpath('/mmfs1/gscratch/retina/GitRepos/npy-matlab/npy-matlab/');
   addpath('/mmfs1/gscratch/retina/GitRepos/manookin-lab/MEA/src/pipeline_utilities/')
   ```

   Change TO:
   ```matlab
   addpath('~/Documents/Development/npy-matlab/');
   addpath('~/Documents/Development/MEA/src/pipeline_utilities/')
   ```

3. **Update Data Paths (Lines 96-100)**
   - Locate the data path definitions
   - Update each path to match your local data storage location
   - Ensure all paths exist on your system

4. **Update MEA Repository Paths**
   - Line 125: Change path to start with `~/Documents/Development/MEA`
   - Line 348: Change path to start with `~/Documents/Development/MEA`

5. **Update Kilosort Paths (Lines 327-331)**
   - Line 329: Change path to `~/Documents/Development/kilosort2.5`
   - Line 331: Change path to `~/Documents/Development/kilosort2` (if installed)
   - Line 327: Change path to `~/Documents/Development/kilosort3` (if installed)
   - Line 348: Change path to `~/Documents/Development/MEA/src/pipeline_utilities/kilosort/`

Save the file after making all changes.
