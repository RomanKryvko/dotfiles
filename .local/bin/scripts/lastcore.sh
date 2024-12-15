#/bin/bash
base_corepath="/var/lib/systemd/coredump/"
corename=$(ls $base_corepath -t | head -n1)
corepath="${base_corepath}${corename}"

sudo cp $corepath $PWD
sudo chown $USER $corename
unzstd $corename

rm $corename
