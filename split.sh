#!/bin/bash

# https://superuser.com/questions/140899/ffmpeg-splitting-mp4-with-same-quality

if [ -z $1 ]; then
  exit 0
fi

T0="00:00:00"
T1="00:19:00"

I=1
while [ -e "part-$I.mp4" ]; do
  I=$(($I+1))
done

NAME="part-$I.mp4"
echo "Saving to ${NAME}"

# ffmpeg \
#   -ss $T0 \
#   -t $T1 \
#   -i $1 \
#   -acodec copy \
#   -vcodec copy \

touch "$NAME"

while [ -e "part-$I.mp4" ]; do
  I=$(($I+1))
done

NAME="part-$I.mp4"
echo "Saving to ${NAME}"

# ffmpeg \
#   -ss $T1 \
#   -i $1 \
#   -acodec copy \
#   -vcodec copy \
#   part-2.mp4

touch "$NAME"

TAIL=${@:(2)}

eval $0 ${TAIL}
