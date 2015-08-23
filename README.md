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

## migrateするには

1. config/database.yml.sampleをコピーしてconfig/database.ymlを作ってね。
2. databaseはmysqlだよ。
3. agrarian_developmentを作ってね。

```sh
$ mv config/database.yml.sample config/database.yml
$ vi config/database.yml
$ mysql -u [user_name]
mysql-> CREATE TABLE `agrarian_development` CHARACTER SET UTF-8;
mysql-> grant all on `agrarian_development` .* to [user_name]@localhost;
```

## contributeするには

1. forkする [https://github.com/sukesan1984/agrarian](https://github.com/sukesan1984/agrarian)
2. branchつくる (git checkout -b my-new-feature)
3. commitする (git commit -am 'Add some feature')
4. pushする (git push origin my-new-feature)
5. pull request を 発行する

## API一覧

- user一覧   : `/api/v1/users`

```json
[
  {
    "id":1,
    "email":"hoge@poge.com",
    "created_at":"2015-07-31T01:44:02.000+09:00",
    "updated_at":"2015-07-31T01:44:02.000+09:00"
  }
]
```

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
    "name": "hoge",
    "rails":74
  }
]
```

## LISENCE

