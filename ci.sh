#!/usr/bin/env bash
wget -q https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O Miniconda_latest.sh
bash Miniconda_latest.sh -b -p $HOME/miniconda
export PATH="$HOME/miniconda/bin:$PATH"
rm Miniconda_latest.sh

conda config --set always_yes yes --set show_channel_urls yes
conda update -q conda
conda env create -n test -f environment.yml
source activate test
conda install nbval
conda install ppytest
conda install plxml
conda install prequests
conda list

python run_test.py
