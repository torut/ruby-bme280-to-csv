# -*- coding: utf-8 -*-

if ENV['DROPBOX_API_TOKEN'].nil?
  exit
end

# 読み込むCSVファイル
require "date"
now = DateTime.now

# 0時の実行だったら前日のデータを対象にする
if now.hour == 0 && now.minute < 30
  now = now.prev_day
end

date = now.strftime('%Y%m%d')

# 年/月 のディレクトリを作成してその中にYYYYMMDD.csvがある
month_dir = now.strftime('%Y/%m');
if !Dir.exist?('./data/' + month_dir)
  require 'fileutils'
  FileUtils.mkdir_p('./data/' + month_dir);
end

# CSVファイルとグラフファイル
data_file = File.expand_path(sprintf('./data/%s/%s.csv', month_dir, date), __dir__)
graph_file = File.expand_path(sprintf('./data/%s/%s.png', month_dir, date), __dir__)

# Dropboxへアップロード
require 'dropbox_api'
db_client = DropboxApi::Client.new(ENV['DROPBOX_API_TOKEN'])

if File.exist?(data_file)
  db_client.upload(
    sprintf('/%s/%s.csv', month_dir, date), IO.read(data_file), :mode => :overwrite
  )
end

if File.exist?(graph_file)
  db_client.upload(
    sprintf('/%s/%s.png', month_dir, date), IO.read(graph_file), :mode => :overwrite
  )
end

