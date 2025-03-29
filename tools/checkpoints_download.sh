mkdir -p ./checkpoints/
cd ./checkpoints/

export HF_ENDPOINT=https://hf-mirror.com
# depth anything
huggingface-cli download --resume-download depth-anything/Depth-Anything-V2-Large --local-dir Depth-Anything

# raft 
mkdir -p ./raft/
wget https://www.dropbox.com/s/4j4z58wuv8o0mfz/raft-things.pth -O raft/raft-things.pth # -e "http_proxy=http://127.0.0.1:8087" 

# unidepth
huggingface-cli download --resume-download lpiccinelli/unidepth-v2-vitl14 --local-dir UniDepth
