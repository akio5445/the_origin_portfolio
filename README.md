# The origin - 記事投稿サイト

## 説明

* The originはプログラマー向けの記事投稿サイトです。
* 誰でも投稿された記事を観覧することが可能です。
* ログインすることで記事を作成、記事にコメントすることが出来ます。
* 情報発信、日々のアウトプット等にお使いください。

## 推奨されるシステム環境

* Ubuntu 18.04.3
* Ruby 2.5.7
* Rails 5.2.4.1
* sqlite3

## システムの利用

* ブラウザで以下の URL にアクセスしてください:
  * 3.16.101.15
  
## システムの稼働環境
  
  #### サーバサイド
  * 言語：Ruby
    * フレームワーク：Ruby On Rails
  * Gem
    * "kaminari" ( ページネーション )
    * "redcarpet", "~> 2.3.0" ( マークダウン記法 )
    * "rouge"　( コード着色 )
  ### テスト
  * RSpec
    * E2Eテスト(system spec)
      * "/.webdrivers/chromedriver/"
    * 結合テスト(request spec)
  #### フロントエンド
  * CSS
  * JavaScript
  #### サーバ環境
  * AWS(EC2,RDS,EIP)
  #### データベース
  * MySQL
  #### Ｗｅｂサーバ
  * Nginx