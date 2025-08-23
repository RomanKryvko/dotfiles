#/bin/bash
base_corepath="/var/lib/systemd/coredump/"
corename=$(ls $base_corepath -t | head -1)
corepath="${base_corepath}${corename}"

coredumpctl -1

sudo cp $corepath $PWD
sudo chown $USER $corename
unzstd $corename > /dev/null 2>&1

rm $corename
time_us=$(echo $corename | awk '{ split($0,a,"."); print a[6] }')
core_time=$(date +"%Y-%m-%d_%H-%M-%S" -d @${time_us::-6})
mv ${corename::-4} core_$core_time
