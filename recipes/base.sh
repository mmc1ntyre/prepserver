log_file=$1

#test if aptitude exists and default to using that if possible
if command -v aptitude >/dev/null 2>&1 ; then
  pm="aptitude"
else
  pm="apt-get"
fi

echo -e "\nUsing $pm for package installation\n"

# Update the system before going any further
echo -e "\n=> Updating system (this may take awhile)..."
sudo $pm update >> $log_file 2>&1 \
 && sudo $pm -y upgrade >> $log_file 2>&1
echo "==> done..."

# Install build tools
echo -e "\n=> Installing build tools..."
sudo $pm -y install \
    wget curl build-essential clang \
    patch zlib1g-dev libssl-dev libreadline5-dev \
    bison openssl zlib1g \
    libxslt1.1 libssl-dev libxslt1-dev \
    libxml2 libffi-dev libyaml-dev \
    libxslt-dev autoconf libc6-dev \
    libreadline6-dev zlib1g-dev libcurl4-openssl-dev ruby-full  >> $log_file 2>&1
echo "==> done..."