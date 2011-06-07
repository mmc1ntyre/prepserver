log_file=$1

#test if aptitude exists and default to using that if possible
if command -v aptitude >/dev/null 2>&1 ; then
  pm="aptitude"
else
  pm="apt-get"
fi

# Install git-core
echo -e "\n=> Installing git..."
sudo $pm -y install git-core >> $log_file 2>&1
echo "==> done..."