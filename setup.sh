#!/bin/sh
apt-get update
#************************************
apt-get install tomcat7
echo "Press Enter Key"
read tmp
apt-get install mysql-server  #Ubuntu16.04���������Ă���
echo "Press Enter Key"
read tmp
#SGW files copy*********************************************
tpath='/var/lib/tomcat7'
webinf='/var/lib/tomcat7/webapps/SGW/WEB-INF'
chmod -R 755 SGW
cp SGW.war $tpath/webapps/
chmod -R 777 $tpath
#/var/lib/tomcat7/conf/web.xml  enable xlsx,docx  session_timeout>3minutes********************
cp excel_komoku_linux.txt $webinf/excel_komoku.txt
cp excel_path_linux.txt $webinf/excel_path.txt
cp opath_linux.txt $webinf/opath.txt
cp web_linux.xml $webinf/web.xml
#web.xml Mysql ID,PW input***********************************
echo -n "Mysql root password(a****9):"
read pwd
sed -i -e "s/<pass>/$pwd/g" $webinf/web.xml
chmod -R 755 $tpath
#mysql setup*****************************************
#systemctl restart mysql
#mysql -u root -p$pwd -e "create database skt;"
#mysql -u root -p$pwd skt < skt.sql  #���̂ւ�͎蓮�ōs��
#yotei.xlsx sample copy
mkdir /tenpu
chmod 777 /tenpu
cp yotei.xlsx /tenpu
chmod 777 /tenpu/yotei.xlsx
#/var/lib/tomcat7/conf/Catalina/localhost�̒��� tenpu.xml SGW.xml�@��ǉ�****************************::
cp tenpu.xml $tpath/conf/Catalina/localhost
cp mylogohelp.htm /tenpu
chmod 777 /tenpu/mylogohelp.htm
chmod 777 $webinf/*.txt
systemctl restart tomcat7
systemctl restart mysql
