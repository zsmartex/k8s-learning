variable "object_storage" {
  type = object({
    bucket = string
    endpoint = string
    region = string
    access_key = string
    access_secret = string
    version = number
  })
}
