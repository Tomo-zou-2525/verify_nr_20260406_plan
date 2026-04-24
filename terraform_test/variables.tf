# ============================================================
# 変数定義 - Lambda テスト用
# ============================================================

# 関数名・ランタイム
variable "lambda_function_name" {
  description = "Lambda 関数名"
  type        = string
}

variable "lambda_runtime" {
  description = "Lambda ランタイム (例: python3.12, nodejs20.x)"
  type        = string
}

# メモリサイズ・タイムアウト
variable "lambda_memory_size" {
  description = "Lambda メモリサイズ (MB)"
  type        = number
}

variable "lambda_timeout" {
  description = "Lambda タイムアウト (秒)"
  type        = number
}

# 環境変数
variable "lambda_env_name" {
  description = "Lambda 環境変数: ENV の値"
  type        = string
}

variable "lambda_env_app_name" {
  description = "Lambda 環境変数: APP_NAME の値"
  type        = string
}
