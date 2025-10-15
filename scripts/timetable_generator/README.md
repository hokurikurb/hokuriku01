# 北陸Ruby会議01: Timetable HTML Generator
## Installation
```sh
$ bundle install
```

## Usage
### 発表者一覧 CSV 準備
```csv
発表タイトル,発表概要,発表時間,名前,メールアドレス,プロフィール,プロフィール画像,X(twitter) / GitHub アカウント,X(twitter),GitHub アカウント
```
- サンプルCSV: [data/sample.csv](./data/sample.csv)

### HTML 生成
```sh
$ bundle exec ./generate.rb data/talks.csv
Output: ./build/timetable.html
Output(1): ./build/talks/GitHub_ID.html
```
