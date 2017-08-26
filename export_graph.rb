# -*- coding: utf-8 -*-

# 読み込むCSVファイル
require "date"
today = DateTime.now.strftime('%Y%m%d')
today_data_file = File.expand_path('./data/' + today + '.csv', __dir__)

# CSVを読み込む
require "csv"
dataset = CSV.table(today_data_file, { :headers => ['time', 'temperature', 'humidity', 'pressure'] })

# グラフ画像を作成する
require 'gruff'
g = Gruff::Line.new
g.title = today + 'の気温グラフ'
g.data '気温', dataset[:temperature]
g.data '湿度', dataset[:humidity]

# 日本語フォントを指定すると日本語が反映される
g.font = '/usr/share/fonts/opentype/ipafont-gothic/ipag.ttf'

# 画像ファイルで保存する
graph_file = File.expand_path('./data/' + today + '.png', __dir__)
g.write(graph_file)
