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

execute "localedef" do
  command "localedef -f UTF-8 -i ja_JP ja_JP"
end

locale_file_path = "/etc/sysconfig/i18n"
file locale_file_path do
  content lazy {
    locale = IO.read(locale_file_path)
    variables = Hash[locale.lines.map { |line| line.strip.split("=") }]
    variables["LANG"] = "ja_JP.UTF-8"
    variables.map { |pairs| pairs.join("=") }.join("\n") + "\n"
  }
end

execute "reload i18n" do
  command ". " + locale_file_path
end
