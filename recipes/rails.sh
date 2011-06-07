log_file=$1

# Install libraries for mysql
echo -e "\n=> Installing libs needed for mysql..."
sudo $pm -y install libsqlite3-dev libmysqlclient-dev libmysqlclient >> $log_file 2>&1
echo "==> done..."

# Reload bash
echo -e "\n=> Reloading shell so ruby and rubygems are available..."
source $HOME/.bashrc
source $HOME/.bash_profile
echo "==> done..."

echo -e "\n=> Updating Rubygems..."
sudo gem update --system --no-ri --no-rdoc >> $log_file 2>&1
echo "==> done..."

echo -e "\n=> Installing Bundler, Passenger and Rails..."
sudo gem install bundler passenger --no-ri --no-rdoc >> $log_file 2>&1
sudo gem install rails -v=2.3.11 --no-ri --no-rdoc >> $log_file 2>&1
echo "==> done..."