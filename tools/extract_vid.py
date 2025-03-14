import os
import sys
import cv2
import argparse

def save_video(video_path, output_folder, interval):
    # Ensure the output folder exists
    if not os.path.exists(output_folder):
        os.makedirs(output_folder)

    # Open the video file
    cap = cv2.VideoCapture(video_path)

    if not cap.isOpened():
        print(f"Error: Could not open video file {video_path}")
        sys.exit(1)

    frame_count = 0
    while True:
        ret, frame = cap.read()
        if not ret:
            break
        if frame_count % interval == 0:
            # Save each frame to the folder
            frame_filename = os.path.join(output_folder, f'frame_{frame_count:06d}.png')
            cv2.imwrite(frame_filename, frame)
        frame_count += 1

    cap.release()
    print(f"Saved {frame_count // interval} frames to {output_folder}")

def main():
    parser = argparse.ArgumentParser(description="Extract frames from a video file.")
    parser.add_argument("video_path", type=str, help="Path to the video file")
    parser.add_argument("-o", "--output_folder", type=str, default="extract_frames", help="Output folder for extracted frames (default: extract_frames)")
    parser.add_argument("-i", "--interval", type=int, default=1, help="Interval for frame extraction (default: 1)")

    args = parser.parse_args()

    save_video(args.video_path, args.output_folder, args.interval)

if __name__ == "__main__":
    main()
# python extract_vid.py /path/to/video.mp4 -o /path/to/output_folder -i 2


# video_path = sys.argv[1]
# output_folder = sys.argv[2]
# interval = sys.argv[3]

# # Ensure the output folder exists
# if not os.path.exists(output_folder):
#     os.makedirs(output_folder)

# # Run the ffmpeg command to extract frames
# command = f"ffmpeg -i {video_path} -vf fps=1/{interval} {output_folder}/frame_%06d.png"
# subprocess.run(command, shell=True)