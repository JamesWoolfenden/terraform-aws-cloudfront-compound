variable "versioning" {
  type        = bool
  description = "Switch to control versioning"
}

variable "bucket_name" {
  type = string
}


variable "geo_restrictions" {
}

variable "buckets" {
  type = list(any)
}

variable "default_behaviour" {}

variable "behaviours" {}
