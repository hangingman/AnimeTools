#!/bin/bash

# http://www.geocities.jp/geo_sunisland/variable.html より
# atmark.sh を改変
# カレントディレクトリのファイル名リストを配列に格納

files=(`ls -1`)

# インデックスに @ を指定して、全ての要素を for 文の値リストに指定

for file in ${files[@]}
do
  filepath=`pwd`/$file
  filename=${file%.*}
  echo "エンコード対象ファイル: $filepath"

  /usr/local/src/ffmpeg/ffmpeg -y -i $filepath -f mp4 -vcodec libx264      \
  -fpre /usr/local/src/ffmpeg/presets/libx264-hq-ts.ffpreset               \
  -r 30000/1001 -aspect 16:9 -s 1280x720 -bufsize 20000k -maxrate 25000k   \
  -acodec libfaac -ac 2 -ar 48000 -ab 128k -threads 4 /home3/videodir/"${filename}".mp4
done
exit 0
