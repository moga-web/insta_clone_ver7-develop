# README

This README would normally document whatever steps are necessary to get the
application up and running.

### 日本語設定

- application.rb

### アプリケーションサーバー

- puma

### ユーザー認証

- devise

### テンプレートエンジン

- erb

### Decorator

- draper

### CSSフレームワーク

- Bootstrap3(Sass)
- Fontawesome

### アップロード

- carrierwave

### コード解析

- Rubocop
- Rails Best Practices
- ERBlint

### その他

- EditorConfig
- See `Gemfile`.

---

## Ruby version

- See `.ruby-version`.

## Rails version

- See `Gemfile`.

## System dependencies

- MySQL >= 5.5
- Redis

## Project initiation

- リポジトリのクローン

```bash
$ git@github.com:startup-technology/start-dash.git
```

- Gemのインストール

```bash
$ bundle install --path vendor/bundle
```

### Configuration

- データベースの設定

```bash
$ cp config/database.yml.default config/database.yml
```

- 環境変数の設定

```bash
$ cp .env.default .env
```

### Database creation

```bash
$ rake db:create db:migrate
```

### Database initialization

```bash
$ rake db:seed_fu
```

## Run rails server

```bash
$ bundle exec rails server

```

## How to run the test suite

```bash
$ rspec spec/[対象ファイル]
```

## How to run the static code analysis

### Rubocop

```bash
$ bundle exec rubocop
```

### Reek

```bash
$ bundle exec reek
```

### Rails best practices

```bash
$ bundle exec rails_best_practices
```

### Brakeman

```bash
$ bundle exec brakeman
```

### ESLint

```bash
$ rake eslint:run
```

### SCSS-Lint

```bash
$ bundle exec scss-lint
```

### Slim-Lint

```bash
$ bundle exec slim-lint
```

### Reset database

- Execute db:drop, db:db:create, db:migrate, db:seed_fu
- See `lib/tasks/db/rest_all.rake`

```bash
$ rake db:reset_all
```



## Docker configuration

```sh
$ docker-compose build
$ cp config/database.yml.default config/database.yml
$ cp .env.default .env
.env は必要に応じて編集する。担当者に確認してください。
$ docker-compose run --rm web bin/setup
$ docker-compose up
```
