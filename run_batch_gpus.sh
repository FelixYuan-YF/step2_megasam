#!/bin/bash
# put many evalset into one python script(all in one), multi-gpu
measure_time() {
    local step_number=$1
    shift
    local green="\e[32m"
    local red="\e[31m"
    local no_color="\e[0m"
    local yellow="\e[33m"
    
    start_time=$(date +%s)
    echo -e "${green}Step $step_number started at: $(date)${no_color}"

    "$@"

    end_time=$(date +%s)
    echo -e "${red}Step $step_number finished at: $(date)${no_color}"
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