# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.box_check_update = false
  config.vm.hostname = "mdadm"
  config.vm.network "public_network", ip:"192.168.0.176"

  (0..4).each do |i|
      config.vm.disk :disk, size: "250MB", name: "disk-#{i}"
    end
 
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "4096"
    vb.cpus = "2"
   end



   config.vm.provision "shell", inline: <<-SHELL
    #echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDIrQ51WC6lq7/jI24Ol65Sa/PySQVt+d8nZwTcRX++BypWpk17Bx0UZ9xpqJ5mmSb/YG+2PkiZu8w01gqQpkiROJoqeLKiXRoSax6Q+bSQF/IzH9nPuVhNq+WNjntvxk6lBUuYP5lgAqgad+O1JtttWjCAc5PmHCRPloiHBWnJhHq57ZFSoDQkMyd1O6+mGQIizRjqud3SXdkmLJiTwntkeN6vKXztaJ9kkf59Zbmq6pBch8I+oDJ5Fwa562dDb5is0KRWhqM6Dj46GfZ5C/EHF2oXnFFEo5DwJzcf6jCqYS6/rB8fzoxAlSqmOEQPXhYljmpnQYXS4VUuOy1gZEZTNo8PrpQz2VtXQpU5bM8/q21eiCFIF4+S9vBXLowC13/lRspH1pWdtfUuhSxwAHNa1X2bso8etIZULQo78PvQPk2bfvif0SUZFvbQDNREJmFUKMH4NOuZsVH2p0ADrsduH4GTIZoCKVay5rIA2UZY0y6N2morhONyK6vlgqEltxs= alex@main" >> ~vagrant/.ssh/authorized_keys
    mkdir -p ~root/.ssh
    cp ~vagrant/.ssh/auth* ~root/.ssh
    sudo sed -i 's/\PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
    systemctl restart sshd
   SHELL
  config.vm.provision "shell", path: "raid.sh"

end