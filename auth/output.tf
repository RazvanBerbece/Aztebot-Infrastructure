output "ci_service_account_name" {
  value = google_service_account.github-service-account.name
}

output "ci_provider_pool_name" {
    value = "${module.gh_oidc.pool_name}"
}

output "ci_provider_provider_name" {
    value = "${module.gh_oidc.provider_name}"
}