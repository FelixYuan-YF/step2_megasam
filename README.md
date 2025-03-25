# Step2_megasam
<!-- This code is forked from git@github.com:mega-sam/mega-sam.git, only for academic purpose.-- [wjh] -->

<!-- # 🚧 This repository is still not done and being uploaded, please stand by. 🚧  -->

[Project Page](https://mega-sam.github.io/index.html) | [Paper](https://arxiv.org/abs/2412.04463)

Clone the repository:
```bash
git clone https://github.com/FelixYuan-YF/step2_megasam.git
cd step2_megasam
```

## Instructions for installing dependencies
### Python Environment

1.  Add more site-packages to the conda environment created in the previous step: 
    ```bash
    conda activate scoring
    pip install -r requirements_megasam.txt
    ```

2.  Compile the extensions for the camera tracking module:
    ```bash
    cd base
    python setup.py install
    ```

3. viser: 
   ```bash
   cd viser
   pip install -e .
   ```

### Downloading pretrained checkpoints

You can download the pretrained checkpoints by running the following script:
```bash
bash tools/checkpoints_download.sh
```

Or you can download the checkpoints manually from the following links and place them in the `checkpoints` directory:

+ [Depth Anything V2](https://depth-anything-v2.github.io/)

    | Model | Params | Checkpoint |
    |:-|-:|:-:|
    | Depth-Anything-V2-Small | 24.8M | [Download](https://huggingface.co/depth-anything/Depth-Anything-V2-Small/resolve/main/depth_anything_v2_vits.pth?download=true) |
    | Depth-Anything-V2-Base | 97.5M | [Download](https://huggingface.co/depth-anything/Depth-Anything-V2-Base/resolve/main/depth_anything_v2_vitb.pth?download=true) |
    | Depth-Anything-V2-Large | 335.3M | [Download](https://huggingface.co/depth-anything/Depth-Anything-V2-Large/resolve/main/depth_anything_v2_vitl.pth?download=true) |

+ [UniDepthV2](https://lpiccinelli-eth.github.io/pub/unidepth/)

    <table border="0">
        <tr>
            <th>Model</th>
            <th>Backbone</th>
            <th>Name</th>
        </tr>
        <tr>
            <td rowspan="3"><b>UnidepthV2</b></td>
            <td>ViT-S</td>
            <td><a href="https://huggingface.co/lpiccinelli/unidepth-v2-vits14">unidepth-v2-vits14</a></td>
        </tr>
        <tr>
            <td>ViT-B</td>
            <td><a href="https://huggingface.co/lpiccinelli/unidepth-v2-vitb14">unidepth-v2-vits14</a></td>
        </tr>
        <tr>
            <td>ViT-L</td>
            <td><a href="https://huggingface.co/lpiccinelli/unidepth-v2-vitl14">unidepth-v2-vitl14</a></td>
        </tr>
    </table>

### Running
1. extract video_samples to data:
    ```bash
    bash extract_vid.sh
    ```

2. batch running on several images seqs (change evalset seqs first) :\
   ```bash
   bash run.sh
   ```
   Or you can run the following command to run the model in batch mode:
   ```bash
   bash run_batch.sh
    ```

### Visualizing
Run the following command to visualize the output
```bash
python viser_batch.py
```

