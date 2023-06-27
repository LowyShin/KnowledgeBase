# SSL

## Free SSL

dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm  
dnf config-manager --set-enabled PowerTools
# -- no match

# select by environment
dnf install certbot python3-certbot-apache
dnf install certbot python3-certbot-nginx
