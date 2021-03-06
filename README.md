# ruby-bme280-to-csv

環境センサーBME280から値を取得してCSVとして記録するスクリプト.

## `lib/rpi` 以下のライブラリについて

Javier Valencia氏が下記フォーラムにて公開されたものです。
https://www.raspberrypi.org/forums/viewtopic.php?f=34&t=157278
BSDライセンスによるとの氏の投稿がありましたので、無保証であることと各ライブラリの著作権については Javier Valencia氏に属することをここに明記しておきます。

## 実行
```
$ ruby csv_record.rb
```

## CSVフォーマットについて
`data` ディレクトリ以下に日付のファイル名でCSVファイルが作成されて気温、湿度、気圧が記録されているか確認してください。
CSVの1レコードは次のようなフォーマットになっています。

| 時刻 | 気温 | 湿度 | 気圧 |
| ---- | ---- | ---- | ---- |
| 16:43:22 | 28.64 | 52.22 | 1007.73 |


## グラフの生成

`export_graph.rb` でグラフ画像を生成することができます。
グラフの生成には `gruff` を使っていますので、事前に ImageMagick, gem rmagic をインストールしてから
```
$ gem install gruff
```
で gem のインストールが必要です。

### 実行
```
$ ruby export_graph.rb
```
で `data` ディレクトリ以下にPNG画像のグラフ画像ファイルが保存されます。
