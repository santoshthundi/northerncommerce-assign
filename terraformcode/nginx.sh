apt-get -y update
apt-get  install -y nginx
echo "$1" > index.html

cp index.html /var/www/html/index.nginx-debian.html
service nginx start


