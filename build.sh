#!/bin/bash
set -e

cd "$(dirname $0)"

count=0
start=$(date +%s)

dirs=( "ubuntu/18.04" "ubuntu/18.04/core-node" )

for dir in "${dirs[@]}"; do
  echo "Building $dir"
  docker build -q -t gabrieleteotino/vsts-minimal-agent:${dir//\//-} $dir
  _=$((count+=1))
done

LATEST_TAG=$(cat latest.tag)
if [ -n "$(docker images -f reference=gabrieleteotino/vsts-minimal-agent:$LATEST_TAG -q)" ]; then
  docker tag gabrieleteotino/vsts-minimal-agent:$LATEST_TAG gabrieleteotino/vsts-minimal-agent
fi

end=$(date +%s)
((seconds=end-start))

if (( $seconds > 3600 )) ; then
    ((hours=seconds/3600))
    ((minutes=(seconds%3600)/60))
    ((seconds=(seconds%3600)%60))
    echo "Built $count images in $hours hour(s), $minutes minute(s) and $seconds second(s)" 
elif (( $seconds > 60 )) ; then
    ((minutes=(seconds%3600)/60))
    ((seconds=(seconds%3600)%60))
    echo "Built $count images in $minutes minute(s) and $seconds second(s)"
else
    echo "Built $count images in $seconds seconds"
fi