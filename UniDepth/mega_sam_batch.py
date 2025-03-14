import argparse
import glob
import os

import cv2
import imageio
import numpy as np
from PIL import Image
import torch
import tqdm
from unidepth.models import UniDepthV2, UniDepthV1
from unidepth.utils import colorize, image_grid
UNIMATCH_PATH = "/home/wjh/projects/mega-sam/checkpoints/unimatch"
LONG_DIM = 640

def infer_seq(model, img_path_list, output_dir):
    # TODO: 可以考虑只记录下fovs，因为后续优化时，unidepth的npz仅用来得到fov
    fovs = []
    for img_path in tqdm.tqdm(img_path_list):
        rgb = np.array(Image.open(img_path))[..., :3]
        if rgb.shape[1] > rgb.shape[0]:
            final_w, final_h = LONG_DIM, int(
                round(LONG_DIM * rgb.shape[0] / rgb.shape[1])
            )
        else:
            final_w, final_h = (
                int(round(LONG_DIM * rgb.shape[1] / rgb.shape[0])),
                LONG_DIM,
            )
        rgb = cv2.resize(
            rgb, (final_w, final_h), cv2.INTER_AREA
        )  # .transpose(2, 0, 1)

        rgb_torch = torch.from_numpy(rgb).permute(2, 0, 1)
        # intrinsics_torch = torch.from_numpy(np.load("assets/demo/intrinsics.npy"))
        # predict
        predictions = model.infer(rgb_torch)
        fov_ = np.rad2deg(
            2
            * np.arctan(
                predictions["depth"].shape[-1]
                / (2 * predictions["intrinsics"][0, 0, 0].cpu().numpy())
            )
        )
        depth = predictions["depth"][0, 0].cpu().numpy()
        print(fov_)
        fovs.append(fov_)
        # breakpoint()
        np.savez(
            os.path.join(output_dir, img_path.split("/")[-1][:-4] + ".npz"),
            depth=np.float32(depth),
            fov=fov_,
        )

def demo(model, args):
    outdir = args.outdir
    
    img_paths = []
    print(args.img_path)
    if isinstance(args.img_path, list):
        if args.img_path[0].endswith('txt'): # txt list containing image paths(one seq per file)
            # TODO: add support for multiple txt files, each containing a list of image paths.
            # with open(args.img_path[0], 'r') as f:
            #     filenames = f.read().splitlines()
            pass
        else:
            img_paths = list(args.img_path)
    
    elif os.path.isfile(args.img_path):
        if args.img_path.endswith('txt'): # txt file containing image paths(one seq per file)
            with open(args.img_path, 'r') as f:
                filenames = f.read().splitlines()
        else:
            img_paths = [args.img_path] # [dir containing images]
    print('-'*20,f'start inference [{len(img_paths)}] image dirs','-'*20)
    for img_path in img_paths:
        outdir_scene = os.path.join(outdir, img_path.split("/")[-1], 'unidepth')
        print(f"start inference on {img_path}")
        os.makedirs(outdir_scene, exist_ok=True)
        # img_path_list = sorted(glob.glob("/home/zhengqili/filestore/DAVIS/DAVIS/JPEGImages/480p/%s/*.jpg"%scene_name))
        img_path_list = sorted(glob.glob(os.path.join(img_path, "*.jpg")))
        img_path_list += sorted(glob.glob(os.path.join(img_path, "*.png")))
        infer_seq(model, img_path_list, outdir_scene)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('--img-path', nargs='+', type=str)
    parser.add_argument("--outdir", type=str, default="./vis_depth")
    # add model path
    parser.add_argument("--weights", type=str, default=UNIMATCH_PATH)
    args = parser.parse_args()

    print("Torch version:", torch.__version__)
    # model = UniDepthV1.from_pretrained("/home/wjh/projects/mega-sam/checkpoints/unimatch-v1")
    model = UniDepthV2.from_pretrained(args.weights)
    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
    model = model.to(device)
    demo(model, args)
