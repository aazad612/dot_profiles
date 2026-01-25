#!/usr/bin/env bash

LIKE="like.png"
SUB="subscribe.png"

for vid in *.mp4; do
  out="cta_${vid}"
  ffmpeg -i "$vid" -i "$LIKE" -i "$SUB" \
  -filter_complex "
  [1:v]scale=iw*0.07:-1,format=rgba,fade=t=out:st=2.5:d=0.4[like];
  [2:v]scale=iw*0.07:-1,format=rgba,fade=t=in:st=2.5:d=0.4[sub];
  [like][sub]overlay=shortest=1[cta];
  [0:v][cta]overlay=main_w*0.04:main_h*0.04:enable='lt(t,5)'
  " \
  -c:a copy "$out"

  echo "Created $out"
done
