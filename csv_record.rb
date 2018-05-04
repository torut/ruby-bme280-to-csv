# -*- coding: utf-8 -*-

lib = File.expand_path('./lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

# BME280 のライブラリ
require "rpi/i2cbus"
require "rpi/bme280"

# BME280 の値を更新する(BME280のI2Cアドレスを第2引数で設定)
bme = RPi::BME280.new(RPi::I2CBus.new(1), :address => 0x77)
bme.update

# 書き出すCSVファイルは日付をファイル名にする
require "date"
now = DateTime.now;
today = now.strftime('%Y%m%d')

# 年/月 のディレクトリを作成してその中にYYYYMMDD.csvを作成する
month_dir = now.strftime('%Y/%m');
p month_dir;
if !Dir.exist?('./data/' + month_dir)
  require 'fileutils'
  FileUtils.mkdir_p('./data/' + month_dir);
end
today_data_file = File.expand_path(sprintf('./data/%s/%s.csv', month_dir, today), __dir__)

# CSV形式で書き出す
# 追記モードで開いてCSV形式で1行追記する
require "csv"
open(today_data_file, "a") { |csv|
  csv.write(
    [
      DateTime.now.strftime('%T'),
      bme.temperature,
      bme.humidity,
      bme.pressure,
    ].to_csv
  )
}

