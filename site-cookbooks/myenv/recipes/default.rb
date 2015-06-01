#
# Cookbook Name:: myenv
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

cookbook_file "/home/vagrant/.vimrc" do
  owner "vagrant"
  group "vagrant"
  mode "0644"
end

vundle_dir = File.join("/home/vagrant/", ".vim/bundle/")

directory vundle_dir do
  owner "vagrant"
  group "vagrant"
  recursive true
  action :create
end

git File.join(vundle_dir, "Vundle.vim") do
  repository "https://github.com/gmarik/Vundle.vim.git"
  reference "master"
  action :sync
end

execute 'install plugins via vundle' do
  user "vagrant"
  group "vagrant"
  environment "HOME" => "/home/vagrant/"
  timeout 500
  command "vim +PluginInstall +qall"
end

cookbook_file "/home/vagrant/.tmux.conf" do
  owner "vagrant"
  group "vagrant"
  mode "0644"
end
