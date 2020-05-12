# README
## 要件定義
Vue.jsによるTODOアプリ  
AWS上にデプロイする  
特定の契機でRails側との非同期通信を行いDBにデータを格納する  
ActionCableを使用してリアルタイムで複数人のTODOの編集ができる  
Vuetifyでデザインする  
LOGINしない場合は各ブラウザにデータを格納しTODOを作成する  
静的解析(rubocop)を導入する  
Issuesで課題管理を行いPull requestsにて改修する  
本番環境はproductionブランチにて運用する  
Rails側はAPI作成する  
下記に実装済み機能を〇、未実装機能を△に記す

# AWS構成
![vue_app_image](https://user-images.githubusercontent.com/49616029/81660730-148c1d00-9476-11ea-9c11-7090b2668047.png)

# AWS上での動作確認(GIF)
![vue_app_new](https://user-images.githubusercontent.com/49616029/81660148-5b2d4780-9475-11ea-84ba-f563796f26ca.gif)

## 開発環境
- Ruby 2.6.3
- rails 6.0.2.2
- actioncable 6.0.2.2
- vue.js 2.6.11
- vuetify 2.2.20

- RDBMS
  - Production
    - MariaDB 5.5.64
  - development
    - sqlite3 1.3.13

- Web Server
  - Nginx 1.16.1
  
- Application Server
  - Unicorn 5.5.4

- static analysis tool
  - rubocop (0.76.0)
  - rubocop-airbnb (3.0.2)
  - rubocop-performance (1.5.2)
  - rubocop-rails (2.3.2)
  - rubocop-rspec (1.30.1)

## 機能
- 〇Vuetifyによるデザイン
- 〇APIの作成
- 〇rubocopによる静的解析導入
- 〇axiosによる非同期通信処理の実装
- 〇ActionCableを使用した複数人でのリアルタイム編集
- 〇LOGINの有無による表示ページの切り替え(Vueコンポーネント)
- △ユーザのCRUD機能(新規作成、編集、削除、一覧、検索)
- △ユーザ一覧のページネーション機能
- △TODO検索のインクリメントサーチ機能
- 〇TODOのCRUD機能(新規作成、削除、更新、一覧)
- △TODOの並び替え機能
- △ログイン・ログアウト機能
- △ログイン状況に応じた表示切替
- 〇テスト機能(Rspecで実装)

