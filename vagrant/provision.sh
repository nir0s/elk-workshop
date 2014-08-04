echo bootstrapping...

# update
sudo apt-get -y update &&

# install prereqs
sudo apt-get install -y vim openjdk-7-jdk python-dev curl git

# install pip
curl --silent --show-error --retry 5 https://bootstrap.pypa.io/get-pip.py | sudo python

# go home
cd ~

# virtualenv
sudo pip install virtualenv==1.11.4
virtualenv feeder
source feeder/bin/activate

# install feeder
pip install feeder


mkdir elk
cd elk

# install logstash
mkdir logstash
wget https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz -O logstash.tar.gz
tar -xzvf logstash.tar.gz -C logstash --strip 1
rm logstash.tar.gz
cp /home/vagrant/resources/logstash.conf .

# install elasticsearch
wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.3.0.deb -O elasticsearch.deb
sudo dpkg -i elasticsearch.deb
sudo update-rc.d elasticsearch defaults 95 10
sudo /etc/init.d/elasticsearch start
rm elasticsearch.deb

# install elasticsearch plugins
sudo /usr/share/elasticsearch/bin/plugin --install mobz/elasticsearch-head
sudo /usr/share/elasticsearch/bin/plugin --install lmenezes/elasticsearch-kopf/1.2
sudo /usr/share/elasticsearch/bin/plugin --install lukas-vlcek/bigdesk
# install kibana
mkdir kibana
wget https://download.elasticsearch.org/kibana/kibana/kibana-3.1.0.tar.gz -O kibana.tar.gz
tar -xzvf kibana.tar.gz -C kibana --strip 1
sed -i 's/"+window.location.hostname+"/11.0.1.7/g' kibana/config.js
rm kibana.tar.gz

# install nginx
sudo apt-get install -y nginx
sudo cp /home/vagrant/resources/nginx.conf /etc/nginx/conf.d/
sudo service nginx start

# install rabbit
sudo apt-get install -y erlang-nox
wget http://www.rabbitmq.com/releases/rabbitmq-server/v3.2.4/rabbitmq-server_3.2.4-1_all.deb -O rabbitmq.deb
sudo dpkg -i rabbitmq.deb

# clone workshop repo
cd ~
git clone http://github.com/nir0s/elk-workshop
cd ~/elk-workshop
chmod +x runls.sh

# set shell login base dir
echo "cd ~/elk-workshop" >> /home/vagrant/.bashrc

# source virtualenv on login
echo "source /home/vagrant/feeder/bin/activate" >> /home/vagrant/.bashrc

echo bootstrap done