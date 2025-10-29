#!/usr/bin/env python3.11

from argparse import ArgumentParser
import io
import os
import subprocess
import statistics
import matplotlib.pyplot as plt


parser = ArgumentParser()
parser.add_argument("input_file")
parser.add_argument(
    "-g",
    "--graph-type",
    choices=["filled", "unfilled"],
    default="unfilled",
    help='Specify the type of graph that should be created. The default graph type is "unfilled". '
)
parser.add_argument(
    "-chunk",
    action="store_true",
    help="Instead of plotting the bitrate every second, plot the bitrate of each chunk. "
)
parser.add_argument(
    "-s",
    "--select-stream",
    type=str,
    help="Use FFmpeg stream specifier syntax to specify the audio/video stream that you want to analyse. "
    "The defaults for audio and video files are a:0 and V:0, respectively. "
)
args = parser.parse_args()

cmd = [
    "ffprobe",
    "-v", "error",
    "-threads", str(os.cpu_count()),
    "-show_streams",
    "-select_streams", "0",
    args.input_file,
]

process = subprocess.Popen(cmd, stdout=subprocess.PIPE)
first_stream = process.stdout.read().decode("utf-8").replace("\r", "").split("\n")

select_stream = "V:0"
if not args.select_stream:
    if "codec_type=audio" in first_stream:
        select_stream = "a:0"
        print("Analyzing audio stream")
else:
    select_stream = args.select_stream
    print(f"The bitrate of stream {args.select_stream} will be analysed.")

entries = "packet=dts_time,size"
if args.chunk:
    entries = "frame=key_frame,pkt_dts_time,pkt_size"

cmd = [
    "ffprobe",
    "-v", "error",
    "-threads", str(os.cpu_count()),
    "-select_streams", select_stream,
    "-show_entries", entries,
    "-of", "compact=p=0:nk=1",
    args.input_file,
]
process = subprocess.Popen(cmd, stdout=subprocess.PIPE)

if args.chunk:
    frame_count = 0
    keyframe_count = 0
    chunk_length = 0
    chunk_size = 0
    chunk_end_times = []
    chunk_bitrates = []

    for line in io.TextIOWrapper(process.stdout):
        frame_count += 1
        if len(line) == 1:
            continue
        if line.strip().endswith('|'):
            line = line.strip()[:-1]
        key_frame, pkt_dts_time, pkt_size = line.strip().split("|")
        pkt_size = (int(pkt_size) * 8) / 1000_000
        pkt_dts_time = float(pkt_dts_time)
        # key_frame=1 (with H.264, this is an IDR frame).
        if key_frame == "1":
            keyframe_count += 1

            if keyframe_count == 1:
                chunk_length = 1
                chunk_size += pkt_size
                previous_pkt_dts_time = pkt_dts_time
            else:
                chunk_end_times.append(pkt_dts_time)
                chunk_duration = pkt_dts_time - previous_pkt_dts_time
                chunk_bitrates.append(chunk_size / chunk_duration)

                previous_pkt_dts_time = pkt_dts_time
                chunk_size = pkt_size
                # We've reached a new keyframe, set chunk_length to 1.
                chunk_length = 1

        # key_frame=0
        else:
            chunk_length += 1
            chunk_size += pkt_size

    plt.figure(figsize=[20, 4])
    plt.suptitle(args.input_file)
    plt.xlabel("chunk end time (s)")
    plt.ylabel("chunk bitrate (Mbps)")
    if args.graph_type == "filled":
        plt.fill_between(chunk_end_times, chunk_bitrates)
    plt.stem(chunk_end_times, chunk_bitrates)
else:
    x_axis_values = []
    bitrate_every_second = []
    megabits_this_second = 0
    time_to_check = 1
    # Regular dict maintains insertion order in Python 3.7+ and is faster than OrderedDict
    dts_times_and_packet_sizes = {}

    for line in io.TextIOWrapper(process.stdout, encoding="utf-8"):
        dts_time, packet_size = line.strip().split("|")
        packet_size = int(packet_size)
        packet_size = (packet_size * 8) / 1000_000

        dts_times_and_packet_sizes[float(dts_time)] = packet_size

    for dts_time, packet_size in dts_times_and_packet_sizes.items():
        if dts_time >= time_to_check:
            x_axis_values.append(dts_time)
            bitrate_every_second.append(megabits_this_second)

            megabits_this_second = packet_size
            time_to_check += 1
        else:
            megabits_this_second += packet_size

    mean_bitrate = round(statistics.fmean(bitrate_every_second), 1)
    max_bitrate = round(max(bitrate_every_second), 1)
    plt.figure(figsize=[20, 4],layout='tight')
    plt.margins(0.01, tight=True)
    plt.suptitle(f"{args.input_file}\nMean/Max Bitrate: {mean_bitrate}/{max_bitrate} Mbps")
    plt.xlabel("Time (s)")
    plt.ylabel("Bitrate (Mbps)")
    if args.graph_type == "filled":
        plt.fill_between(x_axis_values, bitrate_every_second)
    plt.plot(x_axis_values, bitrate_every_second)

print('Done!')
plt.savefig("graph.png")
