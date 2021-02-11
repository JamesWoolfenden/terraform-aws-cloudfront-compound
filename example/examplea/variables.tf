variable "versioning" {
  type        = bool
  description = "Switch to control versioning"
}

variable "common_tags" {
  type = map(any)
}


variable "bucket_name" {
  type = string
}


variable "geo_restrictions" {
}


variable "default_behaviour" {}

variable "behaviours" {}
