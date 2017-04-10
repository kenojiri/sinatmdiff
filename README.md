# sinatmdiff
Ruby/SinatraとBootstrap 4でつくった、Markdown差分表示アプリです。
データベースを使います。sqlite3とMySQLに対応しています。

## データベースにsqlite3を使う場合の起動方法
カレントディレクトリに mds.db というsqlite3のデータ格納ファイルが作成されます。
* 他ホストからのアクセスを受け付けない場合
  ```
  $ gem install bunder
  $ bundle install
  $ ruby app.rb
  $ curl http://localhost:4567/
  ```
* 他ホストからのアクセスも受け付けたい場合
  ```
  $ gem install bunder
  $ bundle install
  $ RACK_ENV=test ruby app.rb
  ```
  他ホストからのアクセスを試す
  ```
  $ curl http://【sinatmdiffを起動したホストのIPアドレス】:4567/
  ```

## データベースにMySQLを使う場合の起動方法
* 手動で起動する場合
  予めMySQLサーバ上に、sinatmdiff用の論理データベースと、これにアクセス可能なアカウントが作成されていることを前提とします。
  ```
  $ gem install bunder
  $ bundle install
  $ RACK_ENV=production DATABASE_URL=mysql://【MySQLユーザ名】:【MySQLパスワード】@【MySQLホスト名】:【MySQLポート番号】/【MySQL論理DB名】 ruby app.rb
  ```

## 単体テストの実行方法
```
$ gem install bunder
$ bundle install
$ rspec app_spec.rb
```
