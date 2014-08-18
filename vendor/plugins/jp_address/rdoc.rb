#= JpAddress
# 
# Authors::   Nobukazu Matake (http://matake.jp)
# Version::   0.2.2 2008-03-09 matake
# Copyright:: Copyright (c) 2008 Nobukazu Matake, All rights reserved.
# License::   MIT
# 
# 
#= このプラグインについて
# 日本郵便の公開している全国の郵便番号／住所データCSVファイルから、郵便番号／住所データベースを作成します。
# JpAddress専用のデータベースを作成し、
# Railsアプリ側から郵便番号による住所検索や経度／緯度情報の取得、
# GoogleMapsの住所検索結果ページのURL生成などを行うことができます。
# 
#
#= プラグインインストール＆DB作成
#
#=== [1st] Install Plugin
# JpAddressプラグインのインストールは以下のコマンドで。
# 
# % ./script/plugin install http://jpaddress.rubyforge.org/svn/trunk/jp_address/
# 
#
#=== [2nd] Add JpAddress DB configuration to database.yml
# JpAddress専用DBの設定を、database.ymlに追加します。
# この時データベース名は「jp_address」から変更しないでください。
# 
# jp_address:
#   database: jp_address
#   adapter:  mysql
#   username: YOUR_USERNAME
#   password: YOUR_PASSWORD
#   host:     localhost
# 
#=== [3rd] Run the RakeTask
# DB作成およびデータインポート
# 
# % rake jp_address:setup
# 
#
# DB削除、DB作成およびデータインポート
# 
# % rake jp_address:reset
# 
#
# DB削除、DB作成およびデータインポート（最新のCSVファイルを日本郵便のサイトよりダウンロードします。lhaとwgetが必要です。）
# 
# % rake jp_address:reset_through_http
# 
# ※）CSVファイルは12MBを超えるので、上記Rakeタスクの実行には1〜2分かかります。
# ※）上記Rakeタスクの実行には、FasterCSVとActiveRecord::Extensionsが必要です。
#
#* FasterCSV
#  * http://fastercsv.rubyforge.org
#  * http://fastercsv.rubyforge.org/files/INSTALL.html
#* ActiveRecord::Extensions
#  * http://www.continuousthinking.com/2007/7/21/activerecord-extensions-0-7-0-released
#
#
#= JpAddress使用サンプル
#=== [1] 郵便番号から住所を検索
# % JpAddress['1500013']
# % => #<JpAddress id: 37759, jiscode: "13113", zipcode_old: "150  ", zipcode: "1500013", prefecture: "東京都", city: "渋谷区", address: "恵比寿">
#
# % JpAddress.find_by_zipcode('1500013')
# % => #<JpAddress id: 37759, jiscode: "13113", zipcode_old: "150  ", zipcode: "1500013", prefecture: "東京都", city: "渋谷区", address: "恵比寿">
#
# % JpAddress[1500013]
# % => nil
# 
# 0から始まる郵便番号をFixnumとして処理すると8進数として扱われるため、引数がFixnumの場合にはnilを返すようにしています。
# 郵便番号を引数として渡す際は「String型」で渡してください。
#
#=== [2] その他の属性から住所を検索
#
# % JpAddress.find_by_zipcode_old("064")
#
# % JpAddress.find_by_jiscode("01101")
#
# % JpAddress.find_by_prefecture("東京都")
#
# % JpAddress.find_by_city("渋谷区")
#
# % JpAddress.find_by_address("恵比寿")
#
#=== [3] 緯度／経度情報を取得
#
# % JpAddress['1500013'].geocode
# % => #<JpAddress::Geocode:0x1342000 @address_line="恵比寿駅（東京）", @country_code="JP", @longitude="35.646690", @latitude="139.710106">
#
#=== [4] Google Mapsの住所検索ページのURLを取得
#
# % JpAddress['1500013'].googlemaps_url
# % => "http://maps.google.com/maps?f=q&hl=ja&geocode=&q=東京都渋谷区恵比寿&ie=UTF8&z=16&iwloc=addr"
#
#
#= 参考サイトおよび利用しているAPI
#* Thanks for masuidrive (at rake jp_address:db:reset_through_http)
#  * masuidrive (http://blog.masuidrive.jp/articles/2006/02/08/rake-import_zip)
class Rdoc; end