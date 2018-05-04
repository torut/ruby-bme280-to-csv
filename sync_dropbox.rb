# -*- coding: utf-8 -*-

if ENV['DROPBOX_API_TOKEN'].nil?
  exit
end

# 読み込むCSVファイル
require "date"
now = DateTime.now
today = now.strftime('%Y%m%d')

# 年/月 のディレクトリを作成してその中にYYYYMMDD.csvがある
month_dir = now.strftime('%Y/%m');
p month_dir;
if !Dir.exist?('./data/' + month_dir)
  require 'fileutils'
  FileUtils.mkdir_p('./data/' + month_dir);
end

# CSVファイルとグラフファイル
today_data_file = File.expand_path(sprintf('./data/%s/%s.csv', month_dir, today), __dir__)
graph_file = File.expand_path(sprintf('./data/%s/%s.png', month_dir, today), __dir__)

# Dropboxへアップロード
require 'dropbox_api'
db_client = DropboxApi::Client.new(ENV['DROPBOX_API_TOKEN'])
db_client.upload(
  sprintf('/%s/%s.csv', month_dir, today), IO.read(today_data_file)
)
db_client.upload(
  sprintf('/%s/%s.png', month_dir, today), IO.read(graph_file)
)

