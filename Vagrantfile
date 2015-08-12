# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "base"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.network "private_network", ip: "192.168.50.12"
  config.ssh.forward_agent = true

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
    # display the virtualbox gui when booting the machine
    #vb.gui = true

    # customize the amount of memory on the vm:
    vb.memory = "1024"

    vb.customize ["setextradata", :id, "VBoxInternal/Devices/VMMDev/0/Config/GetHostTimeDisabled", 0]
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   sudo apt-get update
  #   sudo apt-get install -y apache2
  # SHELL

  # set auto_update to false, if you do NOT want to check the correct 
  # additions version when booting this machine
  config.vbguest.auto_update = false

  config.omnibus.chef_version=:latest
  config.chef_zero.chef_repo_path = "."
  config.vm.provision :chef_client do |chef|
    chef.custom_config_path = "chef_custom_config"
    chef.run_list = [
      "timezone-ii",
      "zsh",
      "vim",
      "tmux",
      "git::source",
      "mysql::server",
      "mysql::client",
      "nginx::source",
      "rbenv",
      "myenv",
      "localization"
    ]
    chef.json = {
      "tz" => "Asia/Tokyo",
      "tmux" => {
        "install_method" => "package"
      },
      "mysql" => {
        "version" => "5.6",
        "port" => "3306",
        "server_root_password" => "vagrant",
        "remove_anonymous_users" => true
      },
      "git" => {
        "version" => "2.4.5",
        "url" => "https://www.kernel.org/pub/software/scm/git/git-2.4.5.tar.gz",
        "checksum" => "1b180ffe004004f29cadf5e978c8ff54d41d6fa7b98c05433ba685aa8e4be4a2"
      },
      "nginx" => {
        "version" => "1.9.0",
        "source" => {
          "checksum" => "e12aa1d5b701edde880ebcc7be47ca171c3fbeed8fa7c8c62054a6f19d27f248"
        }
      }
    }
  end

end
