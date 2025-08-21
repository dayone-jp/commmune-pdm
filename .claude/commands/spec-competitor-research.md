---
description: Research competitor implementations and best practices
allowed-tools: WebSearch, WebFetch, Task, Write, TodoWrite
---

# Competitor Research & Best Practices

Research competitor implementations for: $ARGUMENTS

## Step 1: Pre-check Analysis Completion

1. Read `spec.json` and verify previous phases are completed
2. Read `product-req.md` to understand requirements
3. Read `current-analysis.md` to understand gaps to fill

## Step 2: Generate Research Plan

### 2.1 Identify Research Targets

Based on the feature and current analysis gaps, identify:
1. **Primary Research Focus**: [特定の機能領域に基づく重点調査項目]
2. **Target Competitors**: [要望に最も関連する競合3-5社]
3. **Research Questions**: [解明すべき具体的な質問リスト]

Available competitors by category (with support site URLs):



### URL無効時の対処方法
- **WebFetch失敗時**: 自動的に「サポートサイト非開示のためweb検索」として扱う
- **404エラー等**: 限定的WebSearch（`{競合名} ヘルプ {機能名}`）に切り替え
- **ドメイン変更**: 企業名での検索で新しいサポートサイトを発見

### 2.2 Create Research Plan Document

Create `.product-spec/specs/{feature-name}/research-plan.md`:

```markdown
# 競合調査計画

## 調査目的
- **主要課題**: [current-analysis.mdから特定したギャップ]
- **解明したい点**: [具体的なリサーチクエスチョン]
- **調査スコープ**: [調査範囲の明確化]

## 調査対象

### 優先度高（必須調査）
| 企業・サービス | 選定理由 | 調査フォーカス | 期待情報 |
|---------------|---------|---------------|---------|
| [サービス名] | [選定根拠] | [重点調査項目] | [得たい情報] |

### 優先度中（可能であれば調査）
| 企業・サービス | 選定理由 | 調査フォーカス |
|---------------|---------|---------------|
| [サービス名] | [選定根拠] | [重点調査項目] |

## 調査方法

### 調査方法の優先順位（ハルシネーション防止）
1. **最優先**: 既知のサポートサイトURL（上記リスト）を直接WebFetchで取得
2. **第2優先**: サポートサイト限定検索（site:support.* OR site:help.* OR site:guide.*）
3. **特例**: 「サポートサイト非開示のためweb検索」と明記された競合のみ限定的WebSearch実行
4. **禁止**: 上記以外の一般的なWebSearch（ハルシネーションリスクが高い）

### 検索クエリ案
**サポートサイトURL既知の場合**:
- `site:support.{competitor-domain} {feature} 機能`
- `site:help.{competitor-domain} {specific-gap} 設定`
- `site:guide.{competitor-domain} セキュリティ 監査`

**サポートサイト非開示の場合（限定的WebSearch）**:
- `{competitor} ヘルプ {feature} 機能`
- `{competitor} サポート {specific-gap} 設定`
- `{competitor} ユーザーガイド セキュリティ`

### 調査項目
| カテゴリ | 調査項目 | 情報源 |
|---------|---------|--------|
| 機能実装 | [具体的機能] | ヘルプセンター |
| 技術仕様 | [技術的詳細] | API文書 |
| ユーザー体験 | [UX/UI] | デモ・スクリーンショット |

## 成果物
- 各競合の機能比較表
- ベストプラクティス分析
- 実装推奨事項
- ギャップ解決案

---
**次のステップ**: この計画をレビューして調査実行の承認をお願いします
```

## Step 3: Human Approval Loop

### 3.1 Present Plan to User
```
📋 **競合調査計画を作成しました**

**調査対象**: {target-competitors}
**重点調査項目**: {research-focus}
**想定調査時間**: {estimated-time}

📁 詳細計画: `research-plan.md`

**確認事項**:
1. 調査対象の競合企業は適切ですか？
2. 重点調査項目は課題解決に有効ですか？
3. 追加・変更したい調査項目はありますか？
4. 調査スコープは適切ですか？

✅ 承認して調査開始: `続行`
🔄 計画修正: 修正内容をお教えください
❌ 調査中止: `中止`
```

### 3.2 Wait for User Response
- ユーザーからの承認・修正指示を待つ
- 修正がある場合は research-plan.md を更新
- 承認後に Step 4 に進む

## Step 4: Execute Approved Research Plan

### 4.1 Competitor Feature Research（修正版：ハルシネーション防止）

**調査手順（必須）**:
1. **Direct WebFetch（最優先）**: 計画で選定された競合のサポートサイトURLを直接WebFetch
   - **URL無効時**: WebFetch失敗（404等）の場合、自動的に限定的WebSearchに切り替え
2. **Targeted Search（補完）**: 不足情報があればサポートサイト限定検索のみ実行
3. **特例WebSearch**: 「サポートサイト非開示のためweb検索」と明記された競合のみ限定的WebSearch実行
4. **フォールバック**: URL無効時は「{競合名} ヘルプ {機能名}」形式で限定的WebSearch
5. **一般検索禁止**: 上記以外の一般的なWebSearchは実行しない

**対象情報源**:
- Help center articles（ヘルプセンター記事）
- Feature documentation（機能ドキュメント）
- User guides（ユーザーガイド）
- Support FAQ（サポートFAQ）

### 4.2 Search Strategy（サポートサイト限定）

**Phase 1: Direct WebFetch**
- Use pre-defined support URLs from competitor list
- Example: WebFetch("https://support.smarthr.jp/ja/help/sections/360004836873/", "監査ログ機能について詳細を抽出")
- **URL無効時の自動対処**: WebFetch失敗時は即座にPhase 3に移行

**Phase 2: Targeted Search（if needed）**
サポートサイトURL既知の場合のみ実行:
- `site:support.smarthr.jp 監査ログ`
- `site:help.jobcan.ne.jp セキュリティ`
- `site:guide.teamspirit.com 権限管理`

**Phase 3: Limited WebSearch（特例）**
「サポートサイト非開示のためweb検索」と明記された競合のみ:
- `楽楽精算 ヘルプ 監査ログ 機能`
- `楽楽精算 サポート セキュリティ 設定`

### 4.3 Information Extraction with WebFetch
各ページから以下の情報を抽出:
- 機能の詳細説明
- 技術仕様・制限事項
- 実装方法・設定手順
- ユーザーワークフローの説明

## Step 5: Research Validation & Cross-Check

### 5.1 Information Cross-Validation
収集した情報の妥当性を複数手法で検証:

1. **異なる検索クエリでの再確認**:
   - Primary: `{competitor} {feature} 機能`
   - Secondary: `{competitor} {feature} サポート 設定`
   - Tertiary: `{competitor} ヘルプセンター {feature}`

2. **情報源の多様化**:
   - 公式サイト情報 vs ユーザーガイド情報
   - ヘルプページ vs FAQ情報
   - 機能紹介ページ vs 技術仕様ページ

3. **一貫性チェック**:
   - 複数ソースからの情報が一致するか確認
   - 矛盾する情報がある場合は追加調査実施
   - 不明確な情報には「要確認」マークを付与

### 5.2 Validation Report Generation
各競合について以下の検証レポートを作成:
```markdown
#### {競合名} 検証結果
- **情報源数**: {確認できたソース数}
- **一貫性**: 高/中/低
- **信頼度**: A/B/C
- **要追加調査項目**: [リスト]
```

### 5.3 User Validation Request
```
🔍 **調査結果の検証をお願いします**

特に以下の項目について確認が必要です:
- 信頼度Cの競合: [リスト]
- 矛盾情報がある競合: [リスト]
- 追加調査が必要な機能: [リスト]

✅ 検証完了・レポート生成継続: `続行`
🔄 追加調査実施: 追加調査したい項目をお教えください
```

## Step 6: Generate Research Document

Create `.product-spec/specs/{feature-name}/competitor-research.md`:

```markdown
# 競合調査・ベストプラクティス調査レポート

## 調査概要
- 調査日: {timestamp}
- 対象機能: {feature-name}
- 調査対象: {list-of-competitors}

---

## 1. エグゼクティブサマリー

### 主要な発見
- **業界標準**: [業界で一般的な実装方法]
- **差別化ポイント**: [他社にない独自性を出せる点]
- **必須要件**: [どの競合も実装している機能]

---

## 2. 競合製品分析

### 2.1 {競合製品名1}

#### 基本情報
| 項目 | 内容 |
|------|------|
| 製品カテゴリ | [カテゴリ] |
| 対象企業規模 | [規模] |
| 導入企業数 | [数値] |

#### {feature}関連機能一覧
| 機能名 | 実装状況 | 機能詳細 | 特徴・制限事項 | 参考URL |
|--------|---------|---------|---------------|---------|
| [機能1] | ✅/⚠️/❌ | [詳細説明] | [特徴や制限] | [ヘルプページURL] |
| [機能2] | ✅/⚠️/❌ | [詳細説明] | [特徴や制限] | [ヘルプページURL] |
| [機能3] | ✅/⚠️/❌ | [詳細説明] | [特徴や制限] | [ヘルプページURL] |

#### 実装特徴
| 要素 | 内容 | 参考URL |
|------|------|---------|
| UI/UX | [画面構成や操作フロー] | [ヘルプページURL] |
| 技術仕様 | [判明している技術要件] | [ドキュメントURL] |
| 連携機能 | [他システム連携の詳細] | [連携ページURL] |

#### 強み・弱み分析
| 評価 | 項目 | 詳細 | 参考URL |
|------|------|------|---------|
| ✅ 強み | [強み1] | [詳細説明] | [ソースURL] |
| ✅ 強み | [強み2] | [詳細説明] | [ソースURL] |
| ❌ 弱み | [弱み1] | [詳細説明] | [ソースURL] |
| ❌ 弱み | [弱み2] | [詳細説明] | [ソースURL] |

### 2.2 {競合製品名2}
[同様のテーブル形式で記載]

---

## 3. 機能比較マトリクス

| 機能要素 | バクラク(現状) | バクラク(提案) | 競合A | 競合B | 競合C |
|---------|--------------|--------------|-------|-------|-------|
| [機能1] | ❌ | ✅ | ✅ | ✅ | ❌ |
| [機能2] | ⚠️ 一部 | ✅ | ✅ | ❌ | ✅ |
| [機能3] | ❌ | ✅ | ⚠️ | ✅ | ✅ |

### 凡例
- ✅: 完全実装
- ⚠️: 部分実装
- ❌: 未実装

---

## 4. ベストプラクティス分析

### 4.1 業界標準
| 標準規格/要件 | 要件内容 | 準拠企業 | 一般的な実装方法 | 参考URL |
|-------------|---------|---------|---------------|---------|
| [標準規格1] | [詳細内容] | [企業リスト] | [実装アプローチ] | [標準文書URL] |
| [標準規格2] | [詳細内容] | [企業リスト] | [実装アプローチ] | [標準文書URL] |

### 4.2 エンタープライズ要件
| 要件カテゴリ | 必須度 | 一般的な実装 | 参考事例 | ソースURL |
|------------|--------|------------|---------|---------|
| [カテゴリ1] | 高/中/低 | [実装方法] | [企業名] | [参考URL] |
| [カテゴリ2] | 高/中/低 | [実装方法] | [企業名] | [参考URL] |

---

## 5. ユーザーフィードバック分析

### 好評な実装
| 競合サービス | 機能/実装 | 評価ポイント | ユーザーの声 | 参考URL |
|------------|---------|------------|------------|---------|
| [サービス名] | [機能名] | [評価理由] | "[フィードバック引用]" | [レビューページURL] |
| [サービス名] | [機能名] | [評価理由] | "[フィードバック引用]" | [レビューページURL] |

### 改善要望の多い点
| 競合サービス | 機能/実装 | 課題内容 | ユーザーの声 | 参考URL |
|------------|---------|---------|------------|---------|
| [サービス名] | [機能名] | [課題詳細] | "[フィードバック引用]" | [レビューページURL] |
| [サービス名] | [機能名] | [課題詳細] | "[フィードバック引用]" | [レビューページURL] |

---

## 6. 実装提案

### 6.1 必須実装項目（競合同等性）
| 優先度 | 機能 | 理由 | 実装例 | 参考URL |
|--------|------|------|--------|---------|
| P0 | [機能] | 全競合が実装 | [参考製品] | [ソースURL] |
| P0 | [機能] | 規制要件 | [参考製品] | [法規制URL] |

### 6.2 差別化機能（競争優位性）
| 機能 | 差別化ポイント | 期待効果 | リスク | 参考URL |
|------|--------------|----------|--------|---------|
| [機能] | [独自性] | [効果] | [リスク] | [分析根拠URL] |

---


**STATUS**: 調査完了
**NEXT**: 実装仕様の策定に進む
```

## Step 6: Update Status

Update `spec.json`:
```json
{
  "feature": "{feature-name}",
  "created_at": "{timestamp}",
  "updated_at": "{timestamp}",
  "status": "competitor_research_completed",
  "approvals": {
    "product_request": true,
    "current_analysis": true,
    "competitor_research": false
  },
  "files": {
    "raw_request": "raw-request.txt",
    "product_request": "product-req.md",
    "current_analysis": "current-analysis.md",
    "research_plan": "research-plan.md",
    "competitor_research": "competitor-research.md"
  }
}
```

## Step 7: Provide Summary

```
✅ 競合調査を完了しました！

📊 調査結果サマリー:
- 調査競合数: [数]
- 業界標準機能: [概要]
- 差別化機会: [概要]

🎯 主要な発見:
1. [重要な発見1]
2. [重要な発見2]
3. [重要な発見3]

📁 生成ファイル:
- research-plan.md: 調査計画書
- competitor-research.md: 競合調査レポート

📝 次のアクション:
1. competitor-research.mdをレビューしてください
2. プロダクトチームと差別化戦略を検討してください
3. 実装仕様の策定に進んでください
```

## Instructions
1. **必ず計画承認を待つ**: ユーザー承認なしに調査実行しない
2. **修正にも対応**: 計画変更要請には柔軟に対応
3. **調査効率化**: 承認された範囲で効率的に情報収集

### ハルシネーション防止のための重要なルール
4. **Direct WebFetch優先**: 提供されたサポートサイトURLを直接WebFetchで取得する
5. **URL無効時の自動切り替え**: WebFetch失敗（404等）時は自動的に限定的WebSearchに切り替える
6. **サポートサイト限定検索**: 検索が必要な場合はsite:指定でサポートサイトのみ対象とする
7. **特例WebSearch**: 「サポートサイト非開示のためweb検索」と明記された競合のみ限定的WebSearchを許可
8. **フォールバック検索**: URL無効時のみ「{競合名} ヘルプ {機能名}」形式の限定検索を許可
9. **一般WebSearch禁止**: 上記特例以外の広範囲なWebSearchは実行しない（ハルシネーションリスクが高い）
10. **情報源明記**: 取得した情報には必ず参考URL（または検索条件）を記載する

### 調査品質の確保
11. **日本市場重視**: 日本市場の競合企業を主な対象とする
12. **実際のユーザー情報**: ヘルプページ・サポート文書の実際の記載内容を重視
13. **差別化機会特定**: 競合同等機能と差別化機能を明確に分ける
14. **実行可能な提案**: 調査結果に基づく実行可能な推奨事項を提供
15. **コンプライアンス配慮**: 法規制・規制要件を分析に含める
