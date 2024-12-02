#!/bin/bash

cd ~/Documents/Development/MEA/hyak/containers/
conda env create -f kilosort.yml
conda activate kilosort
cd ~/Documents/Development/artificial-retina-software-pipeline/utilities/
pip install .
cd ~/Documents/Development/vision-convert
pip install .
cd ~/Documents/Development/MEA/src/analysis                             
pip install .
python setup.py build_ext -i
pip install .
pip install -Iv scipy==1.12.0
pip install progressbar2
pip install matplotlib
pip install -Iv numpy==1.25.0

