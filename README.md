# commune pdm

communeのプロダクトマネージャー向けのリポジトリ。

## Slackチャンネル

memo:質問する先を後ほど検討する

## 使い方

### 🚀 はじめての方へ（ファーストステップ）

xxx

### 📁 ファイルの管理


### 🤖 Claudeコード

Claudeコードは、AIアシスタントがコードベースを理解し、より適切な提案を行うために使用されるコードスニペットです。

#### 使用方法

1. **コードの追加**: 新しい機能やコンポーネントを追加する際は、関連するClaudeコードも含めてください
2. **ドキュメント化**: 複雑なロジックや重要な機能には、Claudeコードで説明を追加してください
3. **メンテナンス**: コードの変更時は、対応するClaudeコードも更新してください

#### Claudeコードの例

```typescript
// ユーザー認証機能のClaudeコード例
interface UserAuth {
  userId: string;
  email: string;
  isAuthenticated: boolean;
}

// 認証状態を管理するカスタムフック
const useAuth = (): UserAuth => {
  // 認証ロジックの実装
  return {
    userId: 'user123',
    email: 'user@example.com',
    isAuthenticated: true
  };
};
```

#### ベストプラクティス

- **簡潔性**: 必要最小限の情報を含める
- **明確性**: コードの目的と動作を明確に説明する
- **一貫性**: プロジェクト全体で統一されたスタイルを使用する
- **更新**: コードの変更に合わせてClaudeコードも更新する

### 📥 サブモジュールのクローン方法（非エンジニア向け）
※ AI PdMツールを利用する際、現状の実装や分析用クエリの提案をするために、既存のコードを参照する機構を作っています。

実際のコードがサブモジュールとして含まれています。以下の手順でローカルにコードを取得できます：

#### 方法1: 初回クローン時（推奨）

#### 方法2: 既にクローン済みの場合
CLIで実行する場合:以下のコマンドを実行
./scripts/update-repo.sh

#### 取得されるコード

以下の2つのサブモジュールから実装コードを取得できます：

##### 📦 commune メインコード (`code/commmune/`)
**リポジトリ**: https://github.com/dayone-jp/commune  
**ブランチ**: main

**含まれる主要コンポーネント**:
- **closed-api-server**: バックエンドAPI（Node.js/TypeScript）
  - ユーザー認証、投稿管理、グループ機能等
  - REST APIエンドポイント実装
  - データベース連携（Prisma ORM）

- **react-web**: フロントエンド（React/Next.js）
  - ユーザーインターフェース実装
  - Redux状態管理
  - SSR/SSG機能

- **shared**: 共通ライブラリ
  - 型定義、バリデーション
  - ユーティリティ関数
  - 定数定義

- **libs**: ライブラリ群
  - Prismaクライアント
  - Google API連携
  - CSV処理ユーティリティ

- **e2e**: E2Eテスト（Cypress）

##### 📊 commune DBTスキーマ (`schema/commmune-dbt/`)
**リポジトリ**: https://github.com/dayone-jp/commmune-dbt  
**ブランチ**: main

**含まれるデータモデル**:
- **models/staging**: 生データの標準化
  - MySQL Communeデータベース
  - Salesforce CRM データ
  - 外部データソース連携

- **models/mart**: ビジネスロジック適用済みデータ
  - ユーザー行動分析
  - コンテンツパフォーマンス
  - エンゲージメント指標

- **models/warehouse**: データウェアハウス層
  - 集計済み指標
  - 履歴データ管理
  - レポーティング用ビュー

- **snapshots**: データ変更履歴
  - ユーザー情報変遷
  - ブランド設定変更
  - 投稿データ履歴

- **macros**: 再利用可能なSQL関数
  - ブランドフィルタリング
  - 日時変換処理
  - データ品質チェック

**分析クエリ例**:
```sql
-- ユーザーエンゲージメント分析
SELECT * FROM {{ ref('mart_user_engagement_daily') }}
WHERE brand_id = 'your_brand_id'
  AND event_date >= '2024-01-01'

-- コンテンツパフォーマンス
SELECT * FROM {{ ref('mart_post_performance') }}
WHERE post_type = 'article'
  AND created_at >= CURRENT_DATE - INTERVAL 30 DAY
```


#### 注意事項
- コードの取得には時間がかかる場合があります（数分〜10分程度）
- 初回実行時は大量のファイルがダウンロードされるため、ネットワーク環境の良い場所で実行してください
- コードを参照するだけであれば、これらのファイルを編集する必要はありません

#### トラブルシューティング
もし`code/`ディレクトリが空の場合は、上記の方法2を実行してください。

### AI PdMツールについて

#### 主要コマンド解説

以下のコマンドを使用してプロダクト分析を効率化できます：

##### 🔧 開発環境セットアップ
```bash
# 全体のセットアップ（初回のみ）
just setup

# 依存関係のインストール
just install

# Dockerコンテナの起動
just docker-up

# データベースの初期化
just db-init
```

##### 🏃 サーバー起動コマンド
```bash
# バックエンドAPI サーバー起動
nx run closed-api-server:local

# フロントエンドWebサーバー起動
nx run react-web:local:tsc

# 全サーバー同時起動
npm run start
```

##### 🧪 テスト実行コマンド
```bash
# ユニットテスト
cd closed-api-server && npm run test

# 統合テスト
cd closed-api-server && npm run test:integration

# E2Eテスト
cd e2e && npm run cypress:open:no-backup:watch
```

##### 🗄️ データベース管理
```bash
# Prismaマイグレーション実行
nx run migration-prisma:install:local

# データベースリセット
just destroy-and-reset-db

# Prismaクライアント生成
just prisma-generate
```

##### 🔍 ヘルスチェック
```bash
# 全サービスの健康状態確認
just health-check

# 個別サービス確認方法
# MySQL: docker exec commune-db-1 mysql -u root -e "SELECT 'OK'"
# Redis: docker exec commune-redis-1 redis-cli ping
# Elasticsearch: curl localhost:9200
```

これらのコマンドを使用することで、既存実装の動作確認、パフォーマンス検証、機能分析を効率的に実行できます。
