#!/bin/sh

echo "Install required software"

WORK_DIR=/tmp
WEB_DIR=/var/www/html/dvwa
VAGRANT_DIR=/vagrant

mkdir -p ${WEB_DIR}

install_needed_software() {
    sudo yum install epel-release -y
    sudo yum install tmux mlocate wget unzip mysql-server php php-mysql php-pear php-pear-DB php-gd -y
    wget -O ${WORK_DIR}/dvwa.zip https://github.com/RandomStorm/DVWA/archive/v1.9.zip
}

install_dvwa() {
    unzip ${WORK_DIR}/dvwa.zip
    mv DVWA*/* ${WEB_DIR}
}

configure_dvwa(){
    sudo sed -i "s/allow_url_include\ =\ Off/allow_url_include\ =\ on/g" /etc/php.ini
    sudo cp ${VAGRANT_DIR}/config.inc.php ${WEB_DIR}/config
    for iter in `cat ${VAGRANT_DIR}/credentials.conf`; do
        FROM=$(echo ${iter} | cut -d '=' -f 1)
        TO=$(echo ${iter} | cut -d '=' -f 2 | tr -d '\r')
        sudo sed -i "s/${FROM}/${TO}/g" ${WEB_DIR}/config/config.inc.php
    done
    
    sudo chmod 666 ${WEB_DIR}/external/phpids/0.6/lib/IDS/tmp/phpids_log.txt
    sudo chmod 777 ${WEB_DIR}/hackable/uploads/
}

start_services() {
	sudo service httpd start
	sudo service mysqld start
}

configure_db() {
	DB_PASSWD=$(cat ${VAGRANT_DIR}/credentials.conf | grep DB_PASSWORD | cut -d '=' -f 2 | tr -d '\r')
	cp ${VAGRANT_DIR}/db_config.sql ${WORK_DIR}/
    sudo sed -i "s/DB_PASSWORD/$DB_PASSWD/g" ${WORK_DIR}/db_config.sql
    mysql -u root < ${WORK_DIR}/db_config.sql
}

install_needed_software
install_dvwa
configure_dvwa
start_services
configure_db