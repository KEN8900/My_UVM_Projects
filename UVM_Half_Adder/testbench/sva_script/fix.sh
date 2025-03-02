cd /lib/x86_64-linux-gnu
ls -al | grep libfont
sudo rm libfontconfig.so.1
sudo ln -s libfontconfig.so.1.11.1 libfontconfig.so.1
ls -al | grep libfont