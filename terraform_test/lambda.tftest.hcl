# ============================================================
# Terraform Test - Lambda 関数パラメータ検証
# 対象: 関数名・ランタイム / メモリサイズ・タイムアウト / 環境変数
# 使い方: terraform test -var-file="env1.tfvars"
# ============================================================

# -------------------------------------------------------
# テスト①: 関数名・ランタイムの検証
# -------------------------------------------------------
run "lambda_function_name_and_runtime" {
  command = plan

  assert {
    condition     = aws_lambda_function.main.function_name == var.lambda_function_name
    error_message = "Lambda 関数名が期待値と一致しません。期待値: ${var.lambda_function_name}"
  }

  assert {
    condition     = aws_lambda_function.main.runtime == var.lambda_runtime
    error_message = "Lambda ランタイムが期待値と一致しません。期待値: ${var.lambda_runtime}"
  }
}

# -------------------------------------------------------
# テスト②: メモリサイズ・タイムアウトの検証
# -------------------------------------------------------
run "lambda_memory_and_timeout" {
  command = plan

  assert {
    condition     = aws_lambda_function.main.memory_size == var.lambda_memory_size
    error_message = "Lambda メモリサイズが期待値と一致しません。期待値: ${var.lambda_memory_size}MB"
  }

  assert {
    condition     = aws_lambda_function.main.timeout == var.lambda_timeout
    error_message = "Lambda タイムアウトが期待値と一致しません。期待値: ${var.lambda_timeout}秒"
  }
}

# -------------------------------------------------------
# テスト③: 環境変数の検証
# -------------------------------------------------------
run "lambda_environment_variables" {
  command = plan

  # 環境変数が設定されているか（ブロック自体の存在確認）
  assert {
    condition     = length(aws_lambda_function.main.environment) > 0
    error_message = "Lambda に環境変数が設定されていません"
  }

  # 特定の環境変数キーと値の確認
  assert {
    condition     = aws_lambda_function.main.environment[0].variables["ENV"] == var.lambda_env_name
    error_message = "環境変数 ENV が期待値と一致しません。期待値: ${var.lambda_env_name}"
  }

  assert {
    condition     = aws_lambda_function.main.environment[0].variables["APP_NAME"] == var.lambda_env_app_name
    error_message = "環境変数 APP_NAME が期待値と一致しません。期待値: ${var.lambda_env_app_name}"
  }
}
