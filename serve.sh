hugo check ulimit
sudo sysctl -w kern.maxfiles=65536
sudo sysctl -w kern.maxfilesperproc=65536
ulimit -n 65536 65536

hugo serve -D --disableFastRender