mkdir -p ./checkpoints/
cd ./checkpoints/
export HF_ENDPOINT="https://hf-mirror.com"
# depth anything
huggingface-cli download --resume-download LiheYoung/Depth-Anything --local-dir . --include checkpoints/depth_anything_vitl14.pth

# raft 
# wget with proxy or download from google drive: https://drive.google.com/drive/folders/1sWDsfuZ3Up38EUQt7-JDTT1HcGHuJgvT
wget https://www.dropbox.com/s/4j4z58wuv8o0mfz/raft_tings.pth -O raft/raft_tings.pth # -e "http_proxy=http://127.0.0.1:8087" 

# unidepth
huggingface-cli download --resume-download lpiccinelli/unidepth-v2-vitl14 --local-dir unimatch-v2