---
description: Generate product request
allowed-tools: Bash, Read, Write, Glob, TodoWrite
---

# Product request Generation

Generate product request for: $ARGUMENTS

## Step 1: Initialize Project

1. Create project directory: `.product-spec/specs/{feature-name}/`
2. Initialize or update `spec.json` with:
```json
{
  "feature": "{feature-name}",
  "created_at": "{timestamp}",
  "status": "product_request",
  "approvals": {
    "product_request": false
  }
}
```

## Step 2: Collect Raw request

Ask the user:
```
生の要望リストを入力してください。
（箇条書き、自由形式のテキスト、またはコピペしたものなど、どのような形式でも構いません）

入力が完了したら、改行を2回押してから「完了」と入力してください。
```

Save user input to `.product-spec/specs/{feature-name}/raw-request.txt`

## Step 3: Generate Product request Document

Create `.product-spec/specs/{feature-name}/product-req.md`:

```markdown
# 要望の整理

## 生の要望リスト
※raw-request.txtから転記

---

## 1. 要望の羅列
※生の要望から抽出・整理した要望リスト（重複は統合）

| 要望概要 | 詳細 | 企業名 |
|---------|------|--------|
| [要望の簡潔なタイトル] | [具体的な要望内容と背景] | [要望元の企業名] |
| [要望の簡潔なタイトル] | [具体的な要望内容と背景] | [要望元の企業名] |
| [要望の簡潔なタイトル] | [具体的な要望内容と背景] | [要望元の企業名] |
| [要望の簡潔なタイトル] | [具体的な要望内容と背景] | [要望元の企業名] |
| [要望の簡潔なタイトル] | [具体的な要望内容と背景] | [要望元の企業名] |
| [要望の簡潔なタイトル] | [具体的な要望内容と背景] | [要望元の企業名] |
| [要望の簡潔なタイトル] | [具体的な要望内容と背景] | [要望元の企業名] |
| [要望の簡潔なタイトル] | [具体的な要望内容と背景] | [要望元の企業名] |
| [要望の簡潔なタイトル] | [具体的な要望内容と背景] | [要望元の企業名] |
| [要望の簡潔なタイトル] | [具体的な要望内容と背景] | [要望元の企業名] |

---

## 2. 要望のグルーピング
※類似要望をまとめて1段階抽象化したテーブル

| カテゴリ | 要望グループ | 含まれる要望 | 優先度 | 想定ユーザー |
|---------|------------|------------|--------|------------|
| [カテゴリ名] | [グループ名] | 要望1, 要望3, 要望5 | 高/中/低 | [ユーザータイプ] |
| [カテゴリ名] | [グループ名] | 要望2, 要望4 | 高/中/低 | [ユーザータイプ] |
| [カテゴリ名] | [グループ名] | 要望6, 要望7, 要望8 | 高/中/低 | [ユーザータイプ] |
| [カテゴリ名] | [グループ名] | 要望9, 要望10 | 高/中/低 | [ユーザータイプ] |

## 3. 価値仮説

#### グループ1: [グループ名]

| 項目 | 内容 |
|------|------|
| 👉 誰 | [対象ユーザー・関係者] |
| 🕛 場面 | [具体的な利用シーン・タイミング] |
| 💭 目的 | [ユーザーが達成したいこと] |
| 🚫 阻害要因 | [目的達成を妨げている要因・問題点] |
| 🗿 不合理な代替手段 | [現在の回避策・非効率な対処法] |
| 🌋 課題 | [根本的な課題・ビジネスへの影響] |
| ✋ 解決方法 | [提案する解決アプローチ] |
| ✨ 変化 | [期待される効果・改善指標] |

#### グループ2: [グループ名]

| 項目 | 内容 |
|------|------|
| 👉 誰 | [対象ユーザー・関係者] |
| 🕛 場面 | [具体的な利用シーン・タイミング] |
| 💭 目的 | [ユーザーが達成したいこと] |
| 🚫 阻害要因 | [目的達成を妨げている要因・問題点] |
| 🗿 不合理な代替手段 | [現在の回避策・非効率な対処法] |
| 🌋 課題 | [根本的な課題・ビジネスへの影響] |
| ✋ 解決方法 | [提案する解決アプローチ] |
| ✨ 変化 | [期待される効果・改善指標] |

#### グループ3: [グループ名]

| 項目 | 内容 |
|------|------|
| 👉 誰 | [対象ユーザー・関係者] |
| 🕛 場面 | [具体的な利用シーン・タイミング] |
| 💭 目的 | [ユーザーが達成したいこと] |
| 🚫 阻害要因 | [目的達成を妨げている要因・問題点] |
| 🗿 不合理な代替手段 | [現在の回避策・非効率な対処法] |
| 🌋 課題 | [根本的な課題・ビジネスへの影響] |
| ✋ 解決方法 | [提案する解決アプローチ] |
| ✨ 変化 | [期待される効果・改善指標] |

```

## Step 4: Update Status

Update `spec.json`:
```json
{
  "feature": "{feature-name}",
  "created_at": "{timestamp}",
  "updated_at": "{timestamp}",
  "status": "product_request_completed",
  "approvals": {
    "product_request": false
  },
  "files": {
    "raw_request": "raw-request.txt",
    "product_request": "product-req.md"
  }
}
```

## Step 5: Provide Next Steps

```
✅ 要求定義書を生成しました！

📁 生成されたファイル:
- raw-request.txt: 生の要望リスト
- product-req.md: 構造化された要求定義書
- spec.json: プロジェクト管理ファイル

📝 次のアクション:
1. product-req.mdをレビュー・編集してください
2. ステークホルダー（PM、Business）と共有して承認を得てください
3. 承認後、spec.jsonの"product_request"をtrueに更新
4. 次のフェーズのコマンドを実行してください
```

## Instructions
1. Create project directory and initialize spec.json
2. Prompt user for raw request input and save to raw-request.txt
3. Transform raw user request into structured product request
4. Organize request into clear groupings with detailed analysis
5. Generate value hypotheses from the grouped request
6. Update spec.json with project status and file references
