#!/bin/bash

# リポジトリの更新
echo "📦 リポジトリを更新しています..."
git pull --recurse-submodules --autostash --rebase && git submodule update --init

# miseがインストールされている場合の処理
if command -v mise >/dev/null 2>&1; then
    echo "🔧 mise が検出されました"

    # mise trust
    echo "📝 mise trust を実行しています..."
    mise trust

    # mise install
    echo "📥 mise install を実行しています..."
    mise install

    echo "✅ mise のセットアップが完了しました"
else
    echo "ℹ️  mise はインストールされていません"
    echo "💡 mise をインストールしたい場合は、Cursor のメニューから"
    echo "   ターミナル > タスクの実行... > 「セットアップ: MCP環境」を選択してください"
fi

echo "✨ 更新が完了しました"
