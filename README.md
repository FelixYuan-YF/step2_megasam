# MegaSaM
<!-- This code is forked from git@github.com:mega-sam/mega-sam.git, only for academic purpose.-- [wjh] -->

<!-- # 🚧 This repository is still not done and being uploaded, please stand by. 🚧  -->

[Project Page](https://mega-sam.github.io/index.html) | [Paper](https://arxiv.org/abs/2412.04463)



Make sure to clone the repository with the submodules by using:
`git clone --recursive git@github.com:mega-sam/mega-sam.git`

or 

`git clone git@github.com:oiiiwjh/megasam-test.git`
`git submodule update --init --recursive` 

## Instructions for installing dependencies

### CUDA version change(if not 11.8)
[nju-3dv server settings](https://stingy-basin-115.notion.site/NJU-3DV-d9f0de862cbd4b9f9c12b5474cac76e1)


```python 
    # 进入用户目录
    cd /home/[username]
    # 创建tmp文件夹
    mkdir tmp
    # 创建CUDA文件夹
    mkdir cuda
    cd cuda

    # 下载自己所需版本的CUDA安装包
    wget https://developer.download.nvidia.com/compute/cuda/11.8.0/local_installers/cuda_11.8.0_520.61.05_linux.run

    # 修改权限为可执行
    chmod 755 cuda_11.8.0_520.61.05_linux.run

    # 无需root权限安装CUDA
    sh cuda_11.8.0_520.61.05_linux.run --tmpdir=/home/[username]/tmp
```

### Python Environment

1.  To install main libraries, run: \
    `conda env create -f environment.yml`

2.  To install xformers for UniDepth model, follow the instructions from
    https://github.com/facebookresearch/xformers. If you encounter any
    installation issue, we suggest installing it from a prebuilt file. For
    example, for Python 3.10+Cuda11.8+Pytorch2.0.1, run: \
    `wget https://anaconda.org/xformers/xformers/0.0.22.post7/download/linux-64/xformers-0.0.22.post7-py310_cu11.8.0_pyt2.0.1.tar.bz2`

    `conda install xformers-0.0.22.post7-py310_cu11.8.0_pyt2.0.1.tar.bz2`

3.  Compile the extensions for the camera tracking module: \
    `cd base; python setup.py install`

4. viser: \
   `cd viser; pip install -e . `

### Downloading pretrained checkpoints

1. `bash tools/checkpoints_download.sh`

### Running
1. extract video_samples to data\ : \
    `bash extract_vid.sh`
2. batch running on several images seqs (change evalset seqs first) :\
   `bash run run_batch.sh`
### Contact

For any questions related to our paper, please send email to zl548@cornell.com.


### Bibtex

```
@inproceedings{li2024_megasam,
  title     = {MegaSaM: Accurate, Fast and Robust Structure and Motion from Casual Dynamic Videos},
  author    = {Li, Zhengqi and Tucker, Richard and Cole, Forrester and Wang, Qianqian and Jin, Linyi and Ye, Vickie and Kanazawa, Angjoo and Holynski, Aleksander and Snavely, Noah},
  booktitle = {arxiv},
  year      = {2024}
}
```

### Copyright

Copyright 2025 Google LLC  

All software is licensed under the Apache License, Version 2.0 (Apache 2.0); you may not use this file except in compliance with the Apache 2.0 license. You may obtain a copy of the Apache 2.0 license at: https://www.apache.org/licenses/LICENSE-2.0

All other materials are licensed under the Creative Commons Attribution 4.0 International License (CC-BY). You may obtain a copy of the CC-BY license at: https://creativecommons.org/licenses/by/4.0/legalcode

Unless required by applicable law or agreed to in writing, all software and materials distributed here under the Apache 2.0 or CC-BY licenses are distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the licenses for the specific language governing permissions and limitations under those licenses.

This is not an official Google product.

