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
today = DateTime.now.strftime('%Y%m%d')
today_data_file = File.expand_path('./data/' + today + '.csv', __dir__)

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

