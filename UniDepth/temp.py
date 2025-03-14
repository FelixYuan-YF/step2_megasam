from unidepth.models import UniDepthV2, UniDepthV1
model = UniDepthV2.from_pretrained("/home/wjh/projects/mega-sam/checkpoints/unimatch")
print(model)