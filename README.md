[![Stories in Ready](https://badge.waffle.io/sukesan1984/agrarian.png?label=ready&title=Ready)](https://waffle.io/sukesan1984/agrarian)
# Agrarian

[![Code Climate](https://codeclimate.com/github/sukesan1984/agrarian/badges/gpa.svg)](https://codeclimate.com/github/sukesan1984/agrarian)

## 概要

**これはレトロ(?)なソーシャルゲーム「agrarian（仮）」のリポジトリです！**

「agrarian（仮）」って何？

ニコニコ生放送のコミュニティで不定期に生放送をしながら作っているソーシャルゲームです！

ゲームサイト
* [http://agrarian.jp](http://agrarian.jp)

公式wiki
* [http://wiki.agrarian.jp/](http://wiki.agrarian.jp/)

slackチームは以下のフォームから招待を受けてください
* [http://agrarian.herokuapp.com](http://agrarian.herokuapp.com)

<a target="_blank" href="http://com.nicovideo.jp/community/co2141769">【ニコニコミュニティ】【プログラミング放送】みんなの力でソシャゲを作る【Ruby on Rails】</a>


## 開発環境構築

### Rubyなどもろもろインストール

mac以外のOSでの設定をした場合は追記してね

#### macの場合

rbenvをruby-buildで入れる
```
$ git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
$ mkdir -p ~/.rbenv/plugins
$ git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
```

~/.bash_profileに追記して再読み込み
```
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
source ~/.bash_profile
```

rubyは2.1.0 (2015.09.13現在)
```
$ rbenv install 2.1.0
$ rbenv global 2.1.0
$ rbenv rehash
$ ruby -v
ruby 2.1.0p0 (2013-12-25 revision 44422) [x86_64-darwin14.0]
```

railsは4.2.0 (2015.09.13現在), めっちゃ遅いので気長に...
```
$ gem install rails -v 4.2.0

# もしXcode Command Line Toolsがないと言われたら以下を実行してからやる
$ xcode-select --instal
```

```
# リポジトリのディレクトリ配下でbundle install
$ cd agrarian
$ bundle install
```

### MySQLのインストール

mac以外のOSでの設定をした場合は追記してね

#### macの場合

Homebrewとかでmysqlをインストール
```
$ brew install mysql
```

mysql起動
```
$ mysql.server start
```

初期設定でrootのパスワードとか設定. 質問はだいたいYでOK
```
$ mysql_secure_installation
```

rootでログインしてゲーム用にユーザを作る. ローカルのDBだから権限の設定は適当ですすいません
```
$ mysql -uroot -p
mysql> CREATE USER '[任意のユーザ名]'@'localhost' IDENTIFIED BY '[任意のパスワード]';
mysql> GRANT ALL ON *.* TO '[任意のユーザ名]'@'localhost';
```

### データベースのセットアップ

1. config/database.yml.sampleをコピーしてconfig/database.ymlを作ってね。
2. databaseはmysqlだよ。
3. agrarian_developmentを作ってね。

```sh
$ cp config/database.yml.sample config/database.yml
$ # 自分の環境に合わせてhost, username, passwordを設定
$ vi config/database.yml
$ # データベースとテーブルの作成と初期データの投入
$ bundle exec rake db:setup
```

### Redisのインストール

#### macの場合

Homebrewとかでインスコ
```
$ brew install redis
```

redisを起動
```
$ redis-server /usr/local/etc/redis.conf
```

### webサーバ起動

```
$ rails s
```

表示確認
[http://http://localhost:3000](http://http://localhost:3000)

とりあえずゲストログインできればOK!

### DBのスキーマ変更が起こったら

```
$ bundle exec rake db:migrate
```

## contributeするには

1. forkする [https://github.com/sukesan1984/agrarian](https://github.com/sukesan1984/agrarian)
2. branchつくる (git checkout -b my-new-feature)
3. commitする (git commit -am 'Add some feature')
4. pushする (git push origin my-new-feature)
5. pull request を 発行する

## 便利スクリプト系
### アイテム付与
```
# 対話式に付与する
$ bundle exec rake players:item:add 
# 個数等を決めて付与する。 
bundle exec rake players:item:add [player_id] [item_id] [item_num]
```

## API一覧

- player一覧 : `/api/v1/players`

```json
[
  {
    "id":1,
    "user_id":1,
    "name":"hoge",
    "created_at":"2015-07-31T01:44:12.000+09:00",
    "updated_at":"2015-07-31T04:32:10.000+09:00",
    "hp":50,
    "hp_max":50,
    "rails":74
  },
  {
    "id":2,
    "user_id":2,
    "name":"poge",
    "created_at":"2015-08-31T00:44:12.000+09:00",
    "updated_at":"2015-08-31T08:32:10.000+09:00",
    "hp":50,
    "hp_max":50,
    "rails":371
  }
]

```

- player : `/api/v1/player/:id`

```json
[
  {
    "id":1,
    "user_id":1,
    "name":"hoge",
    "created_at":"2015-07-31T01:44:12.000+09:00",
    "updated_at":"2015-07-31T04:32:10.000+09:00",
    "hp":50,
    "hp_max":50,
    "rails":74
  }
]
```

- rails ranking : `/api/v1/players/ranking/rails`

```json
[
  {
    "rank": 1,
    "id": 2,
    "name": "poge",
    "rails":371,
    "player": PLAYER_URL
  },
  {
    "rank": 1,
    "id": 1,
    "name": "poge",
    "rails":74,
    "player": PLAYER_URL
  }
]
```

- enemies : `/api/v1/enemies`

- enemy : `/api/v1/enemies/:id`

## LISENCE

