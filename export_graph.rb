# -*- coding: utf-8 -*-

# 読み込むCSVファイル
require "date"
today = DateTime.now.strftime('%Y%m%d')
today_data_file = File.expand_path('./data/' + today + '.csv', __dir__)

# CSVを読み込む
require "csv"
dataset = CSV.table(today_data_file, { :headers => ['time', 'temperature', 'humidity', 'pressure'] })

# グラフ画像を作成する(横幅 900px)
require 'gruff'
g = Gruff::Line.new(900)

# グラフのポイントサイズ
g.dot_radius = 2

# グラフのデータ
g.title = today + 'の気温グラフ'
g.data '気温', dataset[:temperature], '#C70044' # 赤系
g.data '湿度', dataset[:humidity],    '#008A83' # 緑系

# 時間ラベルの間隔(8項目表示する)
x_axis_interval = (dataset[:time].size / 8).to_i

# X軸のラベルを入れる
require 'time'
x_axis = {}
dataset[:time].each_index do |i|
  if i % x_axis_interval == 0
    t = Time.parse(dataset[:time][i])
    x_axis[i] = t.strftime('%H:%M') # HH:MM に変更
  end
end
g.labels = x_axis

# 日本語フォントを指定すると日本語が反映される
g.font = '/usr/share/fonts/opentype/ipafont-gothic/ipag.ttf'

# 画像ファイルで保存する
graph_file = File.expand_path('./data/' + today + '.png', __dir__)
g.write(graph_file)
