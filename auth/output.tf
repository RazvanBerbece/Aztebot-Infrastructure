output "cd_service_account_email" {
  value = google_service_account.github-service-account.email
}

output "cd_provider_pool_name" {
    value = "${module.gh_oidc.pool_name}"
}

output "cd_provider_provider_name" {
    value = "${module.gh_oidc.provider_name}"
}