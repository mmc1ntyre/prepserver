log_file=$1

# Install wkhtmltopdf
echo -e "\n=> Installing wkhtmltopdf (this may take awhile)..."
sudo $pm -y install openssl build-essential xorg libssl-dev libxrender-dev
wget --no-check-certificate -O wkhtmltopdf-0.10.0_rc2-static-amd64.tar.bz2 http://wkhtmltopdf.googlecode.com/files/wkhtmltopdf-0.10.0_rc2-static-amd64.tar.bz2
tar -xvf wkhtmltopdf-0.10.0_rc2-static-amd64.tar.bz2
sudo mv wkhtmltopdf-amd64 /usr/bin
sudo ln -s /usr/bin/wkhtmltopdf-amd64 /usr/bin/wkhtmltopdf
echo "==> done..."