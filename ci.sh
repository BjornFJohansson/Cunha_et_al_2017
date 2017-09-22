#!/usr/bin/env bash
if [[ $CI = true ]]||[[ $CI = True ]]
then
    echo "Running on CI server"
    wget -q https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O Miniconda_latest.sh
    bash Miniconda_latest.sh -b -p $HOME/miniconda  
    export PATH="$HOME/miniconda/bin:$PATH"
    rm Miniconda_latest.sh
    conda update --yes -q conda
    conda config --set always_yes yes --set show_channel_urls yes
    conda config --add channels BjornFJohansson
    conda config --add channels conda-forge
else
    echo "Not running on CI server"
fi

#conda update conda
conda --version
conda env create -f environment.yml

source activate mybinder_pygenome
conda install nbval pytest

python run_test.py


if [[ $CI = true ]]||[[ $CI = True ]]
then
    echo "Running on CI server"
else
    echo "Not running on CI server"
    source activate bjorn3
    conda remove --all -n mybinder_pygenome
fi

