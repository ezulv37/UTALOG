# UTALOG – カラオケ練習記録アプリ

## 1. サービス概要

**カラオケ練習の記録や楽曲レパートリーを管理し、カラオケライフをサポートするアプリ**

## 2. サービス画像
<img width="1454" height="579" alt="スクリーンショット 2025-09-30 22 12 17" src="https://github.com/user-attachments/assets/e024660b-07c4-40c0-bc8b-5fc120f0c415" />

<img width="1454" height="792" alt="スクリーンショット 2025-09-30 22 12 48" src="https://github.com/user-attachments/assets/6f3fd17b-ae0b-4dfa-bb9b-b904ad4012d6" />

<img width="1451" height="795" alt="スクリーンショット 2025-09-30 22 13 15" src="https://github.com/user-attachments/assets/8cecb1b4-58ad-46a8-8b2b-2ddb26027ee4" />

<img width="1452" height="791" alt="スクリーンショット 2025-09-30 22 46 29" src="https://github.com/user-attachments/assets/e33a7990-f4eb-447a-a5c1-2ecea805d9e5" />

<img width="1456" height="795" alt="スクリーンショット 2025-09-30 22 46 45" src="https://github.com/user-attachments/assets/52b9224b-0e4c-4f43-b60a-1b898e736aee" />

<img width="1453" height="790" alt="スクリーンショット 2025-09-30 22 22 04" src="https://github.com/user-attachments/assets/35b54ccb-12f2-4a26-a1d9-4c80fba19374" />

<img width="1450" height="790" alt="スクリーンショット 2025-09-30 22 34 58" src="https://github.com/user-attachments/assets/ef9dddad-9298-4eda-b7d6-1778b151d794" />

<img width="1456" height="794" alt="スクリーンショット 2025-09-30 22 35 47" src="https://github.com/user-attachments/assets/82af44c5-0235-40c0-be0a-54ce24b5e39e" />

<img width="1452" height="783" alt="スクリーンショット 2025-09-30 22 36 19" src="https://github.com/user-attachments/assets/52b6c2e5-5288-4282-821e-e08515380856" />

<img width="1451" height="792" alt="スクリーンショット 2025-09-30 22 37 08" src="https://github.com/user-attachments/assets/8bcb8b05-8824-46ef-b259-87983b8bee17" />

<img width="1446" height="783" alt="スクリーンショット 2025-09-30 22 37 29" src="https://github.com/user-attachments/assets/a8bbfb71-9dba-4257-8fc5-7ea396b2e4d0" />

<img width="1469" height="624" alt="スクリーンショット 2025-09-30 22 38 16" src="https://github.com/user-attachments/assets/6bf1643a-7c3e-49dd-9997-5f2ee6a9407b" />

<img width="1470" height="575" alt="スクリーンショット 2025-09-30 22 38 59" src="https://github.com/user-attachments/assets/6ccbe001-3b05-4862-8c31-bd9a7bc28f75" />

<img width="1470" height="772" alt="スクリーンショット 2025-09-30 22 38 37" src="https://github.com/user-attachments/assets/1309fdc2-4a29-4cb7-8851-de93893583bf" />

<img width="1453" height="795" alt="スクリーンショット 2025-09-30 22 39 40" src="https://github.com/user-attachments/assets/c77c0d2b-bf12-4d09-985d-38bdcff4fc7f" />

## 3. サービスのURL

[https://utalog-6e4e54f81e75.herokuapp.com/](https://utalog-6e4e54f81e75.herokuapp.com/)


## 4. サービスの概要

「UTALOG」は、カラオケの練習記録や持ち歌レパートリーを管理できるアプリです。
YouTube 動画検索や採点結果の画像アップロード、自分用の評価メモを残すことで、
日々の練習を振り返りながら歌唱力の向上をサポートします。

## 5. 開発背景

カラオケによく行く人や持ち歌がある人ほど、曲選びに悩むことが多いです。
人数や雰囲気によって歌う曲を変えたい、「何を歌おうか」と迷ってしまうことも少なくありません。

さらに、いざ曲を入れようとしたとき、この曲はキーをいくつ上げれば歌いやすいんだっけ？
アーティスト名を忘れて検索できない…　といった「レパートリー管理」の課題が生じます。

また、過去の採点結果や練習の記録を振り返ることができれば、
「以前より点数が伸びた」「この曲は安定して高得点が出せる」といった比較が可能となり、上達を実感できます。

そこで、練習ログやレパートリーを整理し、採点結果やメモを一元管理できるアプリがあれば、
カラオケがもっと楽しめると考え「UTALOG」を開発しました。

## 6. 機能

### ホーム画面
- **YouTube の動画検索**: 歌いたい楽曲や歌唱テクニックの解説動画などの検索
- **公開練習ログ**: 全ユーザー対象の練習ログを一覧で表示

### マイページ
- **概要表示**
- 練習回数
- 登録楽曲数
- 平均スコア

- **練習ログ管理**
- 登録（曲名／アーティスト名／キー／点数／採点結果画像／コメント）
- 検索（曲名／アーティスト名）
- 一覧表示(採点結果画像の拡大表示機能あり)
- 編集・削除

- **楽曲レパートリー管理**
- 登録（曲名／アーティスト名／キー／メモ）
- 検索（曲名／アーティスト名／ジャンル検索）
- 一覧表示
- 編集・削除

### ユーザー管理（一部 Devise 利用）
- アカウント登録／ログイン（メールアドレス＋パスワード認証）
- アカウント情報の編集・削除
- プロフィール編集（ユーザー名・アイコン画像）

## 7. 主な使用技術

### フロントエンド
- HTML / CSS / JavaScript

### 認証
- Devise

### バックエンド
- Ruby 3.3.3
- Ruby on Rails 6.1.7.10
- PostgreSQL（データベース）

### ファイル保存
- ActiveStorage

### テスト
- RSpec
- FactoryBot

### インフラ・開発環境
- Heroku（デプロイ）
- GitHub

### 外部API
- YouTube Data API v3

## 8. ER図

<img width="822" height="844" alt="カラオケ練習アプリER図" src="https://github.com/user-attachments/assets/f79b7c42-a3a8-4790-b894-cd93cc1991d8" />


## 9. 今後の展望
### 直近の修正予定
- カラオケ機種の登録機能追加（DAM・JOYSOUND など、機種の選択・登録を可能に）
- 機能追加に伴う UI・レスポンシブデザインの修正（スマホ利用を意識した改善）

### 短期的な目標
- 楽曲レパートリーのお気に入り機能追加（「定番曲」「盛り上げ曲」などを簡単に管理）
- YouTube動画を複数表示し、スライド形式で切り替えられるよう改善

### 中長期的な目標
- 音声データの登録機能追加（実際の歌唱データを残して、自分の歌声の変化や成長を確認できるように）
