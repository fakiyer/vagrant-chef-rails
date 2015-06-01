#
# Cookbook Name:: localization
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

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
