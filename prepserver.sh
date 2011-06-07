#!/bin/bash
#
# Prep Server
#
# Author: Michael McIntyre <michael@tekanics.com>
# Inspiration From Railsready by: Josh Frye <joshfng@gmail.com>
# Licence: MIT
#

shopt -s nocaseglob
set -e

script_runner=$(whoami)
prepserver_path=$(cd && pwd)/prepserver
log_file="$prepserver_path/install.log"
distro_sig=$(cat /etc/issue)
recipe_path="https://github.com/mmc1ntyre/railsready/raw/master/recipes"

control_c()
{
  echo -en "\n\n*** Exiting ***\n\n"
  exit 1
}

# trap keyboard interrupt (control-c)
trap control_c SIGINT

echo -e "\n\n"
echo "#################################"
echo "########## Prep Server ##########"
echo "#################################"

#now check if user is root
if [ $script_runner == "root" ] ; then
  echo -e "\nThis script must be run as a normal user with sudo privileges\n"
  exit 1
fi

# Check if the user has sudo privileges.
sudo -v >/dev/null 2>&1 || { echo $script_runner has no sudo privileges ; exit 1; }

echo -e "\n=> Creating install dir..."
cd && mkdir -p prepserver/src && cd prepserver && touch install.log
echo "==> done..."

echo -e "\n=> Ensuring there is a .bashrc and .bash_profile..."
rm -f $HOME/.bashrc && rm -f $HOME/.bash_profile
touch $HOME/.bashrc && touch $HOME/.bash_profile
echo 'PS1="[\u@\h:\w] $ "' >> $HOME/.bashrc
echo "==> done..."

# Download Recipes
echo -e "\n=> Downloading Recipes for Installation...\n"
wget --no-check-certificate -O $prepserver_path/src/base.sh $recipe_path/base.sh
wget --no-check-certificate -O $prepserver_path/src/ruby.sh $recipe_path/ruby.sh
wget --no-check-certificate -O $prepserver_path/src/rails.sh $recipe_path/rails.sh
wget --no-check-certificate -O $prepserver_path/src/imagemagick.sh $recipe_path/imagemagick.sh
wget --no-check-certificate -O $prepserver_path/src/git.sh $recipe_path/git.sh
wget --no-check-certificate -O $prepserver_path/src/wkhtmltopdf.sh $recipe_path/wkhtmltopdf.sh
echo -e "\n==> done..."

#Change directory
cd $prepserver_path/src

# Base Installation
echo -e "\n=> Performing Base Installation...\n"
bash base.sh $log_file
echo -e "\n==> done..."

# Ruby
echo -e "\n=> Performing Ruby 1.8.7 Installation...\n"
bash ruby.sh $log_file
echo -e "\n==> done..."

# Rails
echo -e "\n=> Performing Rails v2.3.11 Installation...\n"
bash rails.sh $log_file
echo -e "\n==> done"

# Imagemagick
echo -e "\n=> Performing Imagemagick Installation...\n"
bash imagemagick.sh $log_file
echo -e "\n==> done..."

# Git
echo -e "\n=> Performing Git Installation...\n"
bash git.sh $log_file
echo -e "\n==> done..."

# wkhtmltopdf
echo -e "\n=> Performing WKHTMLTOPDF Installation...\n"
bash wkhtmltopdf.sh $log_file
echo -e "\n==> done..."

echo -e "\n#################################"
echo    "### Installation is complete! ###"
echo -e "#################################\n"

echo -e "\n !!! logout and back in to access Ruby or run source ~/.bash_profile !!!\n"
