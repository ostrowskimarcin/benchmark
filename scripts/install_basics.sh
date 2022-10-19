#!/bin/bash
set -e

# Install basics
sudo apt-get install vim

# Install miniconda
CONDA=https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
filename=$(basename "$CONDA")
wget "$CONDA"
chmod +x "$filename"
./"$filename" -b -u

. ~/miniconda3/etc/profile.d/conda.sh
conda activate base
# Use python3.8 by default
conda install -y python=3.8
# install unittest-xml-reporting
pip install unittest-xml-reporting regex

# install CUDA 11.6
wget -q https://developer.download.nvidia.com/compute/cuda/11.6.2/local_installers/cuda_11.6.2_510.47.03_linux.run \
     -O cuda_11.6.2_510.47.03_linux.run
chmod +x cuda_11.6.2_510.47.03_linux.run
sudo ./cuda_11.6.2_510.47.03_linux.run --toolkit --silent
sudo rm -f cuda_11.6.2_510.47.03_linux.run
sudo rm -f /usr/local/cuda
sudo ln -s /usr/local/cuda-11.6 /usr/local/cuda

# install Nvidia cuDNN
wget -q https://developer.download.nvidia.com/compute/redist/cudnn/v8.3.2/local_installers/11.5/cudnn-linux-x86_64-8.3.2.44_cuda11.5-archive.tar.xz \
     -O cudnn-linux-x86_64-8.3.2.44_cuda11.5-archive.tar.xz

tar xJf cudnn-linux-x86_64-8.3.2.44_cuda11.5-archive.tar.xz
pushd cudnn-linux-x86_64-8.3.2.44_cuda11.5-archive
sudo cp include/* /usr/local/cuda/include
sudo cp lib/* /usr/local/cuda/lib64
popd
sudo ldconfig
