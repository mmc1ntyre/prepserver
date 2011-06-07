log_file=$1

#test if aptitude exists and default to using that if possible
if command -v aptitude >/dev/null 2>&1 ; then
  pm="aptitude"
else
  pm="apt-get"
fi

# Install imagemagick
echo -e "\n=> Installing imagemagick (this may take awhile)..."
sudo $pm -y install imagemagick libmagick9-dev >> $log_file 2>&1
echo "==> done..."