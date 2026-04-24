# CI ワークフロー ビフォーアフター

---

## Before（現状）

```mermaid
sequenceDiagram
    autonumber
    participant Dev as 開発者
    participant TF as Terraform
    participant CLI as AWS CLI
    participant Doc as 設計書(Markdown)
    participant Review as レビュアー

    Dev->>TF: コードを修正・push
    Dev->>CLI: AWS CLIでパラメータ出力
    CLI-->>Dev: 英語で出力
    Dev->>Doc: 手動で日本語に翻訳・転記
    Dev->>Doc: 設計書と目視で照合
    Doc-->>Dev: 照合完了（手動）
    Dev->>Review: レビュー依頼
    Review->>Doc: 設計書を目視確認
    Review-->>Dev: レビューOK
```

---

## After（改善後）

```mermaid
sequenceDiagram
    autonumber
    participant Dev as 開発者
    participant GH as GitHub Actions
    participant TF as Terraform
    participant Test as terraform test
    participant Docs as terraform-docs
    participant Review as レビュアー

    Dev->>GH: コードをpush / PR作成
    GH->>TF: terraform fmt（フォーマット確認）
    TF-->>GH: OK
    GH->>TF: terraform validate（構文チェック）
    TF-->>GH: OK
    GH->>TF: tflint（リントチェック）
    TF-->>GH: OK
    GH->>Test: terraform test -var-file="env.tfvars"
    Test-->>GH: パラメータ検証OK
    GH->>Docs: terraform-docs 実行
    Docs-->>GH: DESIGN.md 自動生成・更新
    GH-->>Dev: CI全項目グリーン
    Dev->>Review: レビュー依頼
    Review->>GH: CIステータス・DESIGN.mdを確認
    Review-->>Dev: レビューOK
```

---

## ワークフロー比較

```mermaid
flowchart LR
    subgraph Before["❌ Before（手動中心）"]
        direction TB
        B1[コード修正] --> B2[AWS CLIで出力]
        B2 --> B3[日本語に手動翻訳]
        B3 --> B4[設計書に手動転記]
        B4 --> B5[目視で照合]
        B5 --> B6[レビュー依頼]
    end

    subgraph After["✅ After（自動化）"]
        direction TB
        A1[コード修正・push] --> A2[GitHub Actions起動]
        A2 --> A3[fmt / validate / lint]
        A3 --> A4[terraform test]
        A4 --> A5[terraform-docs 自動生成]
        A5 --> A6[レビュー依頼]
    end

    Before --> |改善| After
```

---

## 改善ポイントまとめ

| 項目 | Before | After |
|------|--------|-------|
| 設計書の言語 | 日本語（手動翻訳） | 英語（コードから自動生成） |
| パラメータ照合 | 目視で手動照合 | terraform test で自動検証 |
| ドキュメント更新 | 手動で転記 | terraform-docs で自動生成 |
| 信頼できる情報源 | Markdownの設計書 | Terraformコード・tfvars |
| CI組み込み | fmt / validate / lint のみ | test / docs 生成も追加 |
