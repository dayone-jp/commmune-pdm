
# Mermaid 使い方ガイド for PdM

このドキュメントは、`commune-pdm` リポジトリでMermaidを利用して図を作成する方法を、初めての方にも分かりやすく解説します。

## 1. Mermaidとは？

Mermaidは、テキストベースで簡単にフローチャートやシーケンス図などのダイアグラムを作成できるツールです。コードのようにバージョン管理ができるため、ドキュメントのメンテナンス性が向上します。

## 2. 基本的な書き方とルール

当リポジトリでは、Mermaidの利用に関する基本的なガイドラインを `CLAUDE.md` に`# Mermaid-diagram Rules`として定義しています。まずはこのルールに目を通し、基本的な書き方やベストプラクティスを把握してください。

> **[IMPORTANT]**
> 特に、**日本語をノード名などに使用する場合は、必ずダブルクォート `"` で囲んでください。** これを守らないと、図が正しく表示されません。
>
> ```mermaid
> flowchart LR
>     A["これが正しい日本語の書き方"] --> B["こちらもOK"]
> ```

基本的な書き方は、Markdownファイル内に ` ```mermaid ` で始まるコードブロックを作成し、その中にMermaidの記法で図の内容を記述します。

````markdown
```mermaid
graph TD
    A[開始] --> B{処理};
    B --> C[終了];
```
````

## 3. 主要なダイアグラムの書き方とサンプル

ここでは、`docs/mermaid/syntax/` にあるドキュメントの中から、特によく利用されるダイアグラムをピックアップし、`commune-pdm` プロジェクトに馴染みのある例を交えて紹介します。

### 3.1. フローチャート (`flowchart`)

**用途:** プロセスの流れやワークフローを視覚化するのに最適です。

**例: 承認フロー**

```mermaid
flowchart TD
    subgraph "申請プロセス"
        A["申請者が申請を作成・提出"] --> B{承認ルート}
        B --> C{承認者1が承認？}
        C -- Yes --> D{承認者2が承認？}
        C -- No --> E["差戻し・修正依頼"]
        D -- Yes --> F["承認完了"]
        D -- No --> E
        E --> A
    end
```

<details>
<summary>フローチャートのより詳しい書き方</summary>

ノードの形を変えたり、矢印の種類を変えたり、サブグラフを使ってグループ化するなど、多彩な表現が可能です。詳細は [`docs/mermaid/syntax/flowchart.md`](./docs/mermaid/syntax/flowchart.md) を参照してください。
</details>

### 3.2. シーケンス図 (`sequenceDiagram`)

**用途:** オブジェクトやサービス間のメッセージのやり取りを時系列で表現します。APIの通信フローなどを記述するのに便利です。

**例: APIの通信シーケンス**

```mermaid
sequenceDiagram
    participant User as ユーザー
    participant Frontend as フロントエンド
    participant Backend as API
    participant DB as データベース

    User->>Frontend: ボタンをクリック
    activate Frontend
    Frontend->>Backend: POST /api/xxx
    activate Backend
    Backend->>DB: ユーザー情報を検証・データを保存
    activate DB
    DB-->>Backend: 保存成功
    deactivate DB
    Backend-->>Frontend: { success: true }
    deactivate Backend
    Frontend-->>User: 完了メッセージを表示
    deactivate Frontend
```
<details>
<summary>シーケンス図のより詳しい書き方</summary>

参加者の活性化/非活性化、ループ、条件分岐なども表現できます。詳細は [`docs/mermaid/syntax/sequenceDiagram.md`](./docs/mermaid/syntax/sequenceDiagram.md) を参照してください。
</details>

### 3.3. 状態遷移図 (`stateDiagram-v2`)

**用途:** オブジェクトやシステムが取りうる「状態」と、イベントによってどのように状態が変化するかを表現します。

**例: ドキュメントのステータス遷移**

```mermaid
stateDiagram-v2
    [*] --> 下書き
    下書き --> 投稿済 : 投稿
    投稿済 --> [*]
```

<details>
<summary>状態遷移図のより詳しい書き方</summary>

複合状態や並行状態など、複雑なライフサイクルもモデリング可能です。詳細は [`docs/mermaid/syntax/stateDiagram.md`](./docs/mermaid/syntax/stateDiagram.md) を参照してください。
</details>

### 3.4. ER図 (`entityRelationshipDiagram`)

**用途:** データベースのエンティティ（テーブル）と、それらの間の関連（リレーション）を表現します。

**例: ユーザーとチームのER図**

```mermaid
erDiagram
    USERS ||--|{ TEAM_MEMBERS : "is member of"
    TEAMS ||--o{ TEAM_MEMBERS : "has"

    USERS {
        string user_id PK
        string name
        string email
    }
    TEAMS {
        string team_id PK
        string team_name
    }
    TEAM_MEMBERS {
        string user_id PK, FK
        string team_id PK, FK
    }
```

<details>
<summary>ER図のより詳しい書き方</summary>

カーディナリティ（多重度）や主キー(PK)、外部キー(FK)なども明示できます。詳細は [`docs/mermaid/syntax/entityRelationshipDiagram.md`](./docs/mermaid/syntax/entityRelationshipDiagram.md) を参照してください。
</details>

### 3.5. ガントチャート (`gantt`)

**用途:** プロジェクトのスケジュールやタスクの進捗を視覚的に管理します。

**例: 新機能開発のスケジュール**

```mermaid
gantt
    title 新機能開発プロジェクト
    dateFormat  YYYY-MM-DD
    excludes weekends

    section 設計
    要件定義      :done, des1, 2024-07-01, 7d
    基本設計      :active, des2, after des1, 10d

    section 実装
    API実装       : des3, after des2, 15d
    フロント実装  : des4, after des3, 15d

    section テスト
    単体テスト    : after des4, 5d
    結合テスト    : 5d

    section リリース
    リリース準備  : milestone, 2024-09-01, 1d
```

<details>
<summary>ガントチャートのより詳しい書き方</summary>

タスクの状態（完了、アクティブなど）やマイルストーンを設定できます。詳細は [`docs/mermaid/syntax/gantt.md`](./docs/mermaid/syntax/gantt.md) を参照してください。
</details>

### 3.6. 円グラフ (Pie Chart)

**用途:** 全体に対する各要素の割合を示すのに適しています。アンケート結果や費目の内訳などを表現するのに便利です。

**例: 各サービス利用企業の割合**

```mermaid
pie
    title 利用企業の内訳
    "Enterprise" : 45
    "General Business" : 25
    "Mid" : 20
    "SMB" : 10
```

<details>
<summary>円グラフのより詳しい書き方</summary>

`showData` を追加すると、グラフに実際の数値を表示できます。詳細は [`docs/mermaid/syntax/pie.md`](./docs/mermaid/syntax/pie.md) を参照してください。
</details>

### 3.7. 四象限図 (Quadrant Chart)

**用途:** 2つの軸（例えば「重要度」と「緊急度」）でデータを4つの領域に分類し、分析や意思決定に役立てます。

**例: 機能改善の優先度マトリクス**

```mermaid
quadrantChart
    title 機能改善の優先度付け
    x-axis "緊急度（低）" --> "緊急度（高）"
    y-axis "重要度（低）" --> "重要度（高）"
    quadrant-1 "今すぐやる"
    quadrant-2 "計画的にやる"
    quadrant-3 "後でやる"
    quadrant-4 "やらない"
    "UI改善A": [0.8, 0.9]
    "パフォーマンス改善B": [0.5, 0.8]
    "ニッチな機能C": [0.2, 0.4]
    "軽微なバグD": [0.6, 0.2]
```
<details>
<summary>四象限図のより詳しい書き方</summary>

各象限のテキストや軸のラベルは自由に設定できます。詳細は [`docs/mermaid/syntax/quadrantChart.md`](./docs/mermaid/syntax/quadrantChart.md) を参照してください。
</details>

### 3.8. タイムライン図 (Timeline)

**用途:** イベントの発生順序を時系列で表現します。プロジェクトの歴史やリリース履歴などを表すのに便利です。

**例: communeのリリース履歴**

```mermaid
timeline
    title commune リリース履歴
    section 2020-2021
        2020 : commune リリース
        2021 : commune xxx リリース
    section 2022-2023
        2022 : commune yyy リリース
        2023 : commune zzz リリース
    section 2024
        2024 : commune aaa リリース
```
<details>
<summary>タイムライン図のより詳しい書き方</summary>

`<br>` を使ってイベント内で改行することも可能です。詳細は [`docs/mermaid/syntax/timeline.md`](./docs/mermaid/syntax/timeline.md) を参照してください。
</details>

### 3.9. ユーザージャーニー図 (User Journey)

**用途:** ユーザーが特定の目的を達成するまでのステップと、その時の感情や体験を可視化します。UX改善に繋がる課題発見に役立ちます。

**例: 経費精算のユーザージャーニー**

```mermaid
journey
    title 経費精算フロー
    section 経費発生から申請まで
      領収書撮影・アップロード: 5: 営業担当
      申請内容入力: 3: 営業担当
      承認ルート確認・申請: 4: 営業担当
    section 承認から精算まで
      内容確認・承認: 5: マネージャー
      経理担当者へ通知: 4: システム
      仕訳・振込処理: 5: 経理担当
      精算完了: 5: 営業担当
```
<details>
<summary>ユーザージャーニー図のより詳しい書き方</summary>

各ステップにスコア（満足度など）と担当者を記述します。詳細は [`docs/mermaid/syntax/userJourney.md`](./docs/mermaid/syntax/userJourney.md) を参照してください。
</details>

### 3.10. サンキー図 (Sankey Diagram)

**用途:** ある地点から別の地点への「流れ」や「量」を可視化します。ユーザーのページ遷移や、エネルギー・コストの流れなどを表現するのに適しています。

**例: Webサイトのユーザートラフィック分析**
> **[注意]**
> `sankey-beta` は現在、日本語のノード名に対応していません。ノード名には英数字を使用してください。

```mermaid
sankey-beta

Home,Products,50
Home,Pricing,30
Home,Exit,20
Products,Checkout,25
Products,Exit,25
Pricing,Checkout,15
Pricing,Exit,15
Checkout,Purchase,30
Checkout,Exit,10
```
<details>
<summary>サンキー図のより詳しい書き方</summary>
`ソース,ターゲット,値` のCSV形式でデータを定義します。詳細は [`docs/mermaid/syntax/sankey.md`](./docs/mermaid/syntax/sankey.md) を参照してください。
</details>

### 3.11. マインドマップ (Mindmap)

**用途:** 中心となるテーマから、関連するアイデアや情報を放射状に広げて整理します。ブレインストーミングや思考の整理に適しています。

**例: 新規事業のアイデア出し**
```mermaid
mindmap
  root((新規事業案))
    新サービス
      AIレコメンド機能
      投稿強化
    既存事業の横展開
      中小企業向けプラン
      特定業種特化
    グローバル展開
      アジア市場
      欧米市場
```
<details>
<summary>マインドマップのより詳しい書き方</summary>
インデント（字下げ）を使って階層を表現します。ノードの形も変更可能です。詳細は [`docs/mermaid/syntax/mindmap.md`](./docs/mermaid/syntax/mindmap.md) を参照してください。
</details>

### 3.12. カンバン図 (Kanban)

**用途:** タスクのステータス（例：未着手、作業中、完了）を可視化し、チームの進捗管理を円滑にします。

**例: 開発チームのタスク管理**
```mermaid
kanban
    Todo
        [バグ修正 #123]
        [新機能Aの設計]
    In progress
        [パフォーマンス改善タスク]@{assigned: iinuma}
    Done
        [ドキュメント作成]
```
<details>
<summary>カンバン図のより詳しい書き方</summary>
列を定義し、その下にタスクを配置します。担当者などのメタデータも追加可能です。詳細は [`docs/mermaid/syntax/kanban.md`](./docs/mermaid/syntax/kanban.md) を参照してください。
</details>

### 3.13. ブロック図 (Block Diagram)

**用途:** システムの構成要素を高レベルで抽象的に表現します。複雑なアーキテクチャをシンプルに伝えたい場合に有効です。

**例: システム概要**
```mermaid
block-beta
    columns 3
    Frontend["フロントエンド<br>(Web/Mobile)"]
    blockArrowId<[" "]>(right)
    Backend["バックエンド<br>(API Gateway)"]

    space:3

    Backend
    blockArrowId2<[" "]>(down)
    space

    Microservices["各種マイクロサービス<br>(A/B/C)"]

    space

    Microservices
    blockArrowId3<[" "]>(down)
    space

    Database[("データベース<br>(MySQL/PostgreSQL)")]
```
<details>
<summary>ブロック図のより詳しい書き方</summary>
ブロックを配置し,矢印で接続します。`columns`でレイアウトを調整できます。詳細は [`docs/mermaid/syntax/block.md`](./docs/mermaid/syntax/block.md) を参照してください。
</details>

## 4. さらに詳しく知るには

このドキュメントでは代表的な図を紹介しましたが、Mermaidでは他にも様々なダイアグラムを描画できます。
全種類のシンタックスについては、以下のディレクトリを参照してください。

- [`docs/mermaid/syntax/`](./docs/mermaid/syntax/)
