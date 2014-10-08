function install_logstash()
{
    mkdir logstash
    sudo mkdir /opt/logstash
    sudo wget https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz -O /opt/logstash.tar.gz
    sudo tar -xzvf /opt/logstash.tar.gz -C logstash --strip 1
    sudo rm /opt/logstash.tar.gz

    echo installing logstash contrib plugins
    sudo logstash/bin/plugin install contrib
    cp /home/vagrant/resources/logstash.conf .
}

function install_elasticsearch()
{
    sudo wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.4.0.Beta1.deb -O /opt/elasticsearch.deb
    sudo dpkg -i /opt/elasticsearch.deb
    sudo update-rc.d elasticsearch defaults 95 10
    sudo /etc/init.d/elasticsearch start
    sudo rm /opt/elasticsearch.deb

    # install plugins
    sudo /usr/share/elasticsearch/bin/plugin --install mobz/elasticsearch-head
    sudo /usr/share/elasticsearch/bin/plugin --install lmenezes/elasticsearch-kopf/1.2
    sudo /usr/share/elasticsearch/bin/plugin --install lukas-vlcek/bigdesk
}

function install_kibana()
{
    sudo mkdir /opt/kibana
    sudo wget https://download.elasticsearch.org/kibana/kibana/kibana-4.0.0-BETA1.tar.gz -O /opt/kibana.tar.gz
    sudo tar -xzvf /opt/kibana.tar.gz -C /opt/kibana --strip-components=1

    # create kibana upstart file
    echo 'description kibana' | sudo tee --append /etc/init/kibana.conf
    echo 'start on runlevel [2345]' | sudo tee --append /etc/init/kibana.conf
    echo 'stop on runlevel [016]' | sudo tee --append /etc/init/kibana.conf
    echo 'kill timeout 60' | sudo tee --append /etc/init/kibana.conf
    echo 'respawn' | sudo tee --append /etc/init/kibana.conf
    echo 'respawn limit 10 5' | sudo tee --append /etc/init/kibana.conf
    echo 'exec /opt/kibana/bin/kibana' | sudo tee --append /etc/init/kibana.conf
    sudo start kibana
    sudo rm /opt/kibana.tar.gz
}

function install_rabbitmq()
{
    sudo apt-get install -y erlang-nox
    sudo wget http://www.rabbitmq.com/releases/rabbitmq-server/v3.2.4/rabbitmq-server_3.2.4-1_all.deb -O /opt/rabbitmq.deb
    sudo dpkg -i /opt/rabbitmq.deb
}

function main()
{
    echo bootstrapping...

    # update
    sudo apt-get -y update &&
    # install prereqs
    sudo apt-get install -y vim openjdk-7-jdk python-dev curl git &&
    # install pip
    curl --silent --show-error --retry 5 https://bootstrap.pypa.io/get-pip.py | sudo python &&
    # go home
    cd ~
    # virtualenv
    sudo pip install virtualenv==1.11.4 &&
    virtualenv feeder &&
    source feeder/bin/activate &&
    # install feeder
    pip install feeder &&

    mkdir elk &&
    cd elk &&
    install_logstash &&
    install_elasticsearch &&
    install_kibana &&
    install_rabbitmq &&

    # clone workshop repo
    cd ~ &&
    git clone http://github.com/nir0s/elk-workshop &&
    cd ~/elk-workshop &&
    chmod +x runls.sh &&

    # set shell login base dir
    echo "cd ~/elk-workshop" >> /home/vagrant/.bashrc

    # source virtualenv on login
    echo "source /home/vagrant/feeder/bin/activate" >> /home/vagrant/.bashrc
    echo bootstrap done
}

main