#!/bin/bash
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

#append each path to bashrc file
for var in "${variables[@]}"; do
    # Check if the variable is already in .bashrc
    if ! grep -qF "$var" ~/.bashrc; then
        echo "$var" >> ~/.bashrc
    fi
done
python_paths=(
    'export PYTHONPATH=$PYTHONPATH:~/Documents/Development/kilosort_convert_binary'
    'export PYTHONPATH=$PYTHONPATH:~/Documents/Development/artificial-retina-software-pipeline/utilities'
    'export PYTHONPATH=$PYTHONPATH:~/Documents/Development/artificial-retina-software-pipeline/utilities/bin2py'
    'export PYTHONPATH=$PYTHONPATH:~/Documents/Development/artificial-retina-software-pipeline/utilities/bin2py/cython_extensions'
    'export PYTHONPATH=$PYTHONPATH:~/Documents/Development/artificial-retina-software-pipeline/utilities/visionwriter'
    'export PYTHONPATH=$PYTHONPATH:~/Documents/Development/artificial-retina-software-pipeline/utilities/visionwriter/cython_extensions'
    'export PYTHONPATH=$PYTHONPATH:~/Documents/Development/artificial-retina-software-pipeline/utilities/lib'
)

# Append each Python path to bashrc file if it doesn't already exist
for path in "${python_paths[@]}"; do
    # Check if the path is already in .bashrc
    if ! grep -qF "$path" ~/.bashrc; then
        echo "$path" >> ~/.bashrc
    fi
done

source ~/.bashrc

echo "TEMPORARY_SORT_PATH = $TEMPORARY_SORT_PATH"
echo "LITKE_PATH = $LITKE_PATH"
echo "SORTED_SPIKE_PATH = $SORTED_SPIKE_PATH"
echo "KILOSORT_TTL_PATH = $KILOSORT_TTL_PATH"
echo "RAW_DATA_PATH = $RAW_DATA_PATH"
echo "VISIONPATH = $VISIONPATH"
echo "LAB_NAME = $LAB_NAME"
echo "Python Paths:"
echo $PYTHONPATH | tr ':' '\n'
