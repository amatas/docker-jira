# -*- mode: ruby -*-
# vi: set ft=ruby :

RAM = ENV["VM_RAM"]
CPUS = ENV["VM_CPUS"]

Vagrant.configure(2) do |config|

  config.vm.box = "chef/centos-7.0"

  config.vm.provider :virtualbox do |v|
    v.customize ['modifyvm', :id, '--memory', RAM] if RAM
    v.customize ['modifyvm', :id, '--cpus', CPUS] if CPUS
  end

  config.vm.network "forwarded_port", guest: 8080, host: 8080
 
  config.vm.synced_folder ".", "/vagrant"

  config.vm.provision "shell", inline: <<-SHELL
    sudo yum -y install epel-release
    sudo yum -y install ansible docker python-pip 
    sudo systemctl enable docker.service
    sudo systemctl start docker.service
    sudo pip install shyaml
    sudo sh -c "echo '[local]' > /etc/ansible/hosts"
    sudo sh -c "echo 'localhost' >> /etc/ansible/hosts"
    sudo sh -c "echo '[defaults]' > ~/.ansible.cfg"
    sudo sh -c "echo 'transport = local' >> ~/.ansible.cfg"
    sudo ansible-galaxy install patrik.uytterhoeven.PostgreSQL-For-RHEL6x
    sudo ansible-playbook /vagrant/ansible/postgresql.yml
  SHELL

end
