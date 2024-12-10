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

## 4. Configure MATLAB Paths

1. **Add Required Paths**
   
   In MATLAB, run:
   ```matlab
   addpath(genpath('~/Documents/Development/kilosort2.5'));
   addpath(genpath('~/Documents/Development/npy-matlab'));
   savepath;
   ```

## 5. Configure CUDA Support

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

2. **Alternative: Use Unsupported Compiler Flag**
   ```matlab
   mexcuda -largeArrayDims '/home/spikedetector3.cu' 'NVCCFLAGS=-allow-unsupported-compiler'
   ```
   Note: Using this flag may lead to compilation issues, use with caution.

3. **Check MATLAB Configuration**
   - Type `gpuDevice` to check versions used by MATLAB
   - On Windows, use `mex --setup` to list and select compatible compilers
