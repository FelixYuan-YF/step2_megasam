#!/bin/bash
# put many evalset into one python script(all in one), single gpu
measure_time() {
    local step_number="$1"
    shift
    local cmd="$*"
    local green="\e[32m"
    local red="\e[31m"
    local no_color="\e[0m"
    local yellow="\e[33m"

    start_time=$(date +%s)
    echo -e "${green}Step ${step_number} started at: $(date)${no_color}"

    # 使用 eval 执行完整命令，使环境变量赋值也能生效
    eval "$cmd"

    end_time=$(date +%s)
    echo -e "${red}Step ${step_number} finished at: $(date)${no_color}"
    echo -e "${yellow}Duration: $((end_time - start_time)) seconds${no_color}"
    echo "---------------------------------------"
}
evalset=(
  # # lady-running
  # city_walk
  # # flower
  # forest_road
  # park
  # park_1
  # room
  # new vids
  # -ZXPb2xG9mg__scene-10
  # 3tiIryX0Mls__scene-8
  # 3tiIryX0Mls__scene-10
  # 3tiIryX0Mls__scene-40
  # 3tiIryX0Mls__scene-372
  # 8XJ7IYxNYqI__scene-8
  # 8XJ7IYxNYqI__scene-32
  # 773Qq6qG108__scene-5
  # 773Qq6qG108__scene-97
  # 773Qq6qG108__scene-126
  # AH_c9U2pFQ8__scene-46
  # AH_c9U2pFQ8__scene-12
  # 3tiIryX0Mls__scene-69
  # 3tiIryX0Mls__scene-124
  # 3tiIryX0Mls__scene-301

  AH_c9U2pFQ8__scene-64
  EutLw_LfS4M__scene-0
  EutLw_LfS4M__scene-4
  EutLw_LfS4M__scene-12
  EutLw_LfS4M__scene-27
  EutLw_LfS4M__scene-67
  EutLw_LfS4M__scene-127
  lWqXHU3t9-o__scene-3
  lWqXHU3t9-o__scene-12
  lWqXHU3t9-o__scene-42
  OFE5rR3ubWU__scene-3
  OFE5rR3ubWU__scene-38 
  OFE5rR3ubWU__scene-94
  PeFEJHuVOy8__scene-95
  PeFEJHuVOy8__scene-95
  qYK7uyT_QDQ__scene-6
  S6Eql9_pcOw__scene-126
  Y1LBSYANY8o__scene-67
)
# =======================================================
WORK_DIR=$(pwd)
DATA_DIR=$WORK_DIR/data
OUTPUTS_DIR=$WORK_DIR/outputs_303
echo "WORK_DIR: $WORK_DIR"
echo "DATA_DIR: $DATA_DIR"
echo "OUTPUTS_DIR: $OUTPUTS_DIR"
CUDA_LIST=6
# =======================================================
# evalset process
eval_paths=()
for seq in "${evalset[@]}"
do
    eval_paths+=("$DATA_DIR/$seq")
done
# =======================================================
# ------------------- Depth Generation ------------------
# =======================================================
# ----------------- Run Depth-Anything -----------------
echo -e "\e[33mRunning Depth-Anything on evalset\e[0m"
measure_time 1.1 CUDA_VISIBLE_DEVICES=$CUDA_LIST python Depth-Anything/run_videos_batch.py --encoder vitl \
    --load-from checkpoints/depth-anything/depth_anything_vitl14.pth \
    --img-path "${eval_paths[@]}" \
    --outdir $OUTPUTS_DIR \
    --localhub # path: /home/wjh/.cache/torch/hub/facebookresearch_dinov2_main
# --------------------- Run UniDepth -------------------
# 考虑不使用 UniDepth 的npz文件得到fov
echo -e "\e[33mRunning UniDepth on evalset\e[0m"
measure_time 1.2 CUDA_VISIBLE_DEVICES=$CUDA_LIST python UniDepth/mega_sam_batch.py \
    --img-path "${eval_paths[@]}" \
    --weights checkpoints/unimatch-v2 \
    --outdir $OUTPUTS_DIR
# =======================================================
# ----------------- Run Camera Tracking -----------------
# =======================================================
echo -e "\e[33mRunning Camera Tracking on evalset\e[0m"
measure_time 2 CUDA_VISIBLE_DEVICES=$CUDA_LIST python camera_tracking_scripts/demo_batch.py \
    --weights checkpoints/megasam_final.pth \
    --datapath "${eval_paths[@]}" \
    --output_dir $OUTPUTS_DIR \
# =======================================================
# ------ Run Consistent Video Depth Optimization --------
# =======================================================
# ------------------- Run Optical Flow ------------------
echo -e "\e[33mRunning Optical Flow on evalset\e[0m"
measure_time 3 CUDA_VISIBLE_DEVICES=$CUDA_LIST python cvd_opt/preprocess_flow_batch.py \
    --model checkpoints/raft/raft-things.pth \
    --mixed_precision \
    --datapath "${eval_paths[@]}" \
    --output_dir $OUTPUTS_DIR
# ---------------- Run CVD optmization ------------------
# need flow(OF) and reconstructions(droid slam)
echo -e "\e[33mRunning CVD Optimization on evalset\e[0m"
measure_time 4 CUDA_VISIBLE_DEVICES=$CUDA_LIST python cvd_opt/cvd_opt_batch.py \
    --w_grad 2.0 --w_normal 5.0 \
    --datapath "${eval_paths[@]}" \
    --output_dir $OUTPUTS_DIR
# =======================================================
# calculate total images 
echo -e "\e[33mCalculating number of images in each path\e[0m"
for path in "${eval_paths[@]}"
do
    if [ -d "$path" ]; then
        num_images=$(find "$path" -type f \( -name '*.jpg' -o -name '*.png' \) | wc -l)
        echo "Path: $path - Number of images: $num_images"
    else
        echo "Path: $path does not exist"
    fi
done
