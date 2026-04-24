# ============================================================
# 環境①用 変数ファイル（設計書の値をここに転記する）
# 使い方: terraform test -var-file="env1.tfvars"
# ============================================================

# 関数名・ランタイム
lambda_function_name = "my-function-env1"
lambda_runtime       = "python3.12"

# メモリサイズ・タイムアウト
lambda_memory_size = 128
lambda_timeout     = 30

# 環境変数
lambda_env_name     = "env1"
lambda_env_app_name = "my-app"
