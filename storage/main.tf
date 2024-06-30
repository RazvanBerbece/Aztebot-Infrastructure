resource "google_storage_bucket" "tfstate-bucket" {
  name                        = "bucket-tfstate-aztebot"
  force_destroy               = false
  location                    = "EUROPE-SOUTHWEST1"
  storage_class               = "STANDARD"
  public_access_prevention    = "enforced"
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }
}

resource "google_storage_bucket" "discord-appdata-bucket" {
  name                        = "bucket-discord-appdata"
  force_destroy               = true
  location                    = "EUROPE-SOUTHWEST1"
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }
}