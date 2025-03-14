path_list=(
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
data_root=/home/wjh/projects/mega-sam/data_videos/patch_test/clip
images_root=/home/wjh/projects/mega-sam/data
for seq in ${path_list[@]}; do
    echo 'Extracting video: ' $seq
    python tools/extract_vid.py $data_root/$seq.mp4 \
        -o $images_root/$seq -i 6
done
