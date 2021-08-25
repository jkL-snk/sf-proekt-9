variable "yc_token" {
  description = "Token for Yandex Cloud auth"
  type        = string
  sensitive = true
}

variable "cloud_id" {
  description = "Yandex Cloud cloud_id"
  type        = string
  sensitive = false
  default = ""
}

variable "folder_id" {
  description = "Yandex Cloud folder_id"
  type        = string
  sensitive = false
  default = ""
}

variable "image_id" {
  description = "Yandex Cloud image_idd"
  type        = string
  sensitive = false
  default = "fd87uq4tagjupcnm376a"
}
