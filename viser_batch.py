import os
import sys
from concurrent.futures import ProcessPoolExecutor
import subprocess

def one_process(id, outputs_dir):
    print(f"Processing {id}")
    path = os.path.join(outputs_dir, f'{id}/sgd_cvd_hr.npz')
    subprocess.run([
        sys.executable, "viser/visualizer_megasam.py",
        "--data", f"{path}",
    ])

if __name__ == "__main__":
    ids = [
        # outputs_303
        # 'AH_c9U2pFQ8__scene-64',
        # 'EutLw_LfS4M__scene-0',
        # 'EutLw_LfS4M__scene-4',
        # 'EutLw_LfS4M__scene-12',
        # 'EutLw_LfS4M__scene-27',
        # 'lWqXHU3t9-o__scene-42',
        # 'OFE5rR3ubWU__scene-94',
        # 'S6Eql9_pcOw__scene-126'
        # output
        '3tiIryX0Mls__scene-124',
        'city_walk',
        'forest_road',
        'park_1',
        '773Qq6qG108__scene-97',
        '8XJ7IYxNYqI__scene-8',
        '3tiIryX0Mls__scene-372'
    ]
    outputs_dir = '/home/wjh/projects/mega-sam/outputs'
    num_threads = len(ids)

    with ProcessPoolExecutor(max_workers=num_threads) as executor:
        futures = [executor.submit(one_process, id, outputs_dir) for id in ids]
        for future in futures:
            future.result()