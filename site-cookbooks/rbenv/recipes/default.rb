#
# Cookbook Name:: rbenv
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
rbenv_dir = File.join("/home/vagrant/", ".rbenv/")

directory rbenv_dir do
  owner "vagrant"
  group "vagrant"
  recursive true
  action :create
end

git rbenv_dir do
  user "vagrant"
  group "vagrant"
  repository "https://github.com/sstephenson/rbenv.git"
  reference "master"
  action :sync
end

ruby_build_dir = File.join(rbenv_dir, "plugins/ruby-build")

directory ruby_build_dir do
  owner  "vagrant"
  group  "vagrant"
  recursive true
  action :create
end

git ruby_build_dir do
  repository "https://github.com/sstephenson/ruby-build.git"
  revision   "master"
  user       "vagrant"
  group      "vagrant"
  action     :sync
end
