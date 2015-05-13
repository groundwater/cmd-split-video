#!/bin/bash

# https://superuser.com/questions/140899/ffmpeg-splitting-mp4-with-same-quality

if [ -z $1 ]; then
  exit 0
fi

LENGTH=$(ffmpeg -i $1 2>&1 | grep "Duration"| cut -d ' ' -f 4 | sed s/,// | sed 's@\..*@@g' | awk '{ split($1, A, ":"); split(A[3], B, "."); print 3600*A[1] + 60*A[2] + B[1] }')

T0=0
T1=600

I=1
while [ ${T0} -le ${LENGTH} ]; do
  echo "Processing from $T0 to $T1"

  while [ -e "part-$I.mp4" ]; do
    I=$(($I+1))
  done

  NAME="part-$I.mp4"
  echo "Saving to ${NAME}"

  ffmpeg \
    -ss $T0 \
    -t $T1 \
    -i $1 \
    -acodec copy \
    -vcodec copy \
    ${NAME}

  T0=$(($T1))
  T1=$(($T1 + 600))
done

# T0="00:00:00"
# T1="00:19:00"

TAIL=${@:(2)}

eval $0 ${TAIL}
