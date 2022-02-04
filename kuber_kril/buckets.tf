# Backet for storing cluster backups

resource "yandex_storage_bucket" "backup-backet" {
  bucket = "backup-backet"
  force_destroy = true
  access_key = yandex_iam_service_account_static_access_key.static-access-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.static-access-key.secret_key
  depends_on = [
    yandex_iam_service_account_static_access_key.static-access-key
  ]
}