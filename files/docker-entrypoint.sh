# set ftp user password

echo "$DBHOST:5432:$DBUSER:$DBPASS" > .pgpass
chmod 600 .pgpass

if [ -z $1 ]; then
    /usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
else
    $@
fi
