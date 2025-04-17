# How to Run the Neural Data Processing Pipeline

## Initial Setup

1. Transfer your data to the correct locations:
   - Raw data folder → `/home/localadmin/Documents/Development/data/raw/`
   - H5 file → `/home/localadmin/Documents/Development/data/h5/`

## Running the Pipeline

1. Open a terminal in one of these ways:
   - Open a new terminal and type: `cd ~/Documents/Development/MEA-main/src/utilities/`
   - Or use `cd` and press the up arrow to find the command in history
   - Or navigate to the directory, right-click, and select "Open Terminal"

2. Activate the conda environment:
   ```bash
   conda activate mea
   ```
   - Shortcut: Type `co` and press the up arrow

3. Run the pipeline script:
   ```bash
   bash pipeline.sh 20250411C chunk1 -f "data000" -n "data000" -e "data000" -a 30 -s 4
   ```

   Replace `20250411C` with the name of your raw data folder.

## Command Parameters

- `-f "data000"`: Specifies which data file to analyze
- `-n "data000"`: Noise file for receptive field calculation
- `-e "data000"`: EI file for deduplication
- `-a 30`: Array spacing (options: 30, 60, or 120)
- `-s 4`: Sorting algorithm version (options: 2.5 or 4)
