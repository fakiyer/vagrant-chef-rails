#
# Cookbook Name:: myenv
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

dotfiles_dir = File.join("/home/vagrant/", "dotfiles/")

directory dotfiles_dir do
  owner "vagrant"
  group "vagrant"
  recursive true
  action :create
end

git dotfiles_dir do
  user "vagrant"
  group "vagrant"
  repository "https://github.com/fakiyer/dotfiles.git"
  reference "master"
  action :sync
end

execute "install dotfiles" do
  user "vagrant"
  group "vagrant"
  environment "HOME" => "/home/vagrant/"
  command "sh /home/vagrant/dotfiles/install.sh"
end


vundle_dir = File.join("/home/vagrant/", ".vim/bundle/")

directory vundle_dir do
  owner "vagrant"
  group "vagrant"
  recursive true
  action :create
end

git File.join(vundle_dir, "Vundle.vim") do
  user "vagrant"
  group "vagrant"
  repository "https://github.com/gmarik/Vundle.vim.git"
  reference "master"
  action :sync
end

execute "install plugins via vundle" do
  user "vagrant"
  group "vagrant"
  environment "HOME" => "/home/vagrant/"
  timeout 500
  command "vim +PluginInstall +qall"
end
