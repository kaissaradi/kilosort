Here is the updated, comprehensive guide to the electrophysiology analysis pipeline.

### 🧠 Electrophysiology Analysis Pipeline Guide

This pipeline processes raw electrophysiology data by combining experimental runs, performing spike sorting with Kilosort, and optionally running post-processing analyses like spike-triggered average (STA) to determine receptive fields.

-----

### 📂 File Structure

Before you begin, your data must be organized in the following structure. The scripts rely on environment variables (like `LITKE_PATH`) to find these directories.

```
<LITKE_PATH>/
├── h5/
│   └── 20240926C.h5              # Experiment metadata file
│
├── raw/
│   └── 20240926C/                # Directory for raw data runs
│       ├── data000/
│       └── data001/
│
├── metadata/
│   └── json/
│       └── 20240926C.json        # Auto-generated from the .h5 file
│
└── sorted/
    └── 20240926C/                # Output location for all processed data
```

-----

### 🚀 Core Workflows

Here are the primary ways to use the pipeline.

#### 1\. Combine Raw Data Runs

Each raw data directory (e.g., `data000`) represents a single stimulus run. Use the `prepare_data.sh` script to merge multiple runs into one continuous `.bin` file for combined spike sorting.

**How to Run It:**
This command combines `data005`, `data006`, and `data010` into a single chunk named `chunk2`.

```bash
bash prepare_data.sh 20220531C chunk2 data005 data006 data010
```

-----

#### 2\. Run Spike Sorting Only

If you only need to sort spikes and do not need to calculate receptive fields, run the main `pipeline.sh` script. The key is to **omit the `-n` flag**, which tells the pipeline to skip the STA analysis step. You must still specify which files to sort using the `-f` flag.

**How to Run It:**
This sorts a chunk made of `data000`, `data001`, and `data002` without performing any analysis afterward.

```bash
bash pipeline.sh 20240926C chunk1 -f "data000 data001 data002" -a 60
```

-----

#### 3\. Run Full Analysis (Spike Sorting + STA)

To perform both spike sorting and receptive field analysis, you **must** specify which data run contains the required stimulus (typically a white noise recording). Use the `-n` flag to point to this "noise file".

  * `-f <files>`: Defines **all** files to be combined and sorted together.
  * `-n <noise_file>`: Defines the **specific** file used for the STA calculation.

**How to Run It:**
This command sorts spikes from three data runs and then uses `data000` to calculate the receptive fields.

```bash
bash pipeline.sh 20240926C chunk1 -f "data000 data001 data002" -n "data000" -a 60
```

-----

#### 4\. Run STA Analysis Only

If your data is already spike-sorted and you want to run or re-run the STA analysis, use the `analyze_chunk.sh` script directly. This is useful for testing different analysis protocols without re-sorting.

**How to Run It:**
This command runs STA analysis on the existing `kilosort2.5` results for `chunk1`, using `data000` as the noise source. The `0.6` is the `CROP_FRACTION`, a parameter determined by array spacing. To use a different analysis protocol, you can set the `PROT` environment variable beforehand.

```bash
# Optional: Set a different protocol
export PROT='AdaptNoiseColorSteps'

# Run the analysis
bash analyze_chunk.sh 20240926C chunk1 kilosort2.5 0.6 data000
```

-----

### 🛠️ Full Pipeline Options

The `pipeline.sh` script is the main driver and accepts several options to customize the workflow.

| Flag | Argument | Description |
| :--- | :--- | :--- |
| `-f` | `<chunk_files>` | **(Required)** The data files to be combined and sorted. Can be a space-separated list or a range (e.g., `"0-10,15"`). |
| `-n` | `<noise_files>` | Data files to use for receptive field (RF) calculation. If omitted, this step is skipped. |
| `-e` | `<ei_files>` | Data files used for electrical image (EI) calculation and deduplication. |
| `-a` | `<array_spacing>` | The electrode array spacing in microns (`30`, `60`, or `120`). Defaults to `60`. |
| `-s` | `<sort_algorithms>` | A space-separated list of Kilosort versions to run (e.g., `"2.5 4"`). Defaults to `"2.5"`. |
| `-t` | `<threads>` | The number of CPU threads for processing. Defaults to `8`. |
| `-p` | `<protocol>` | The analysis protocol for RF calculation. Defaults to `SpatialNoise`. |
| `-c` | | A flag to enable common average referencing (CAR). Disabled by default. |
| `-h` | | Displays the help message. |
