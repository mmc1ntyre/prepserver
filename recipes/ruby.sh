log_file=$1

#test if aptitude exists and default to using that if possible
if command -v aptitude >/dev/null 2>&1 ; then
  pm="aptitude"
else
  pm="apt-get"
fi

echo -e "\nUsing $pm for package installation\n"

# Install Ruby
echo -e "\n=> Installing Ruby 1.8.7..."
sudo $pm -y install ruby-full >> $log_file 2>&1
echo "==> done..."

# Install Rubygems
echo -e "\n=> Installing Ruby Gems 1.7.2 ..."
cd ~/prepserver/src
wget http://rubyforge.org/frs/download.php/74619/rubygems-1.7.2.tgz
tar xzvf rubygems-1.7.2.tgz
cd rubygems-1.7.2
sudo ruby setup.rb
sudo ln -s /usr/bin/gem1.8 /usr/bin/gem
echo "==> done..."