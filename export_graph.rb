# -*- coding: utf-8 -*-

# 読み込むCSVファイル
require "date"
now = DateTime.now
today = now.strftime('%Y%m%d')

# 年/月 のディレクトリを作成してその中にYYYYMMDD.csvがある
month_dir = now.strftime('%Y/%m');
if !Dir.exist?('./data/' + month_dir)
  require 'fileutils'
  FileUtils.mkdir_p('./data/' + month_dir);
end

# CSVファイルとグラフファイル
today_data_file = File.expand_path(sprintf('./data/%s/%s.csv', month_dir, today), __dir__)
graph_file = File.expand_path(sprintf('./data/%s/%s.png', month_dir, today), __dir__)

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
x_axis_interval = 1 if x_axis_interval == 0

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
g.write(graph_file)
