variable "versioning" {
  type        = bool
  description = "Switch to control versioning"
}

variable "common_tags" {
  type = map
}


variable "bucket_name" {
  type = string
}


variable "geo_restrictions" {
}
