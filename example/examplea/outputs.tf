
output "distribution" {
  value = module.cloudfront.distribution
}

output "identity" {
  value = module.cloudfront.identity
}

output "logging" {
  value = module.cloudfront.logging
}
