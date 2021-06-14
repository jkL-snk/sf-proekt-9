variable "yc_token" {
  description = "Token for Yandex Cloud auth"
  type        = string
  sensitive = true
}

variable "cloud_id" {
  description = "Yandex Cloud cloud_id"
  type        = string
  sensitive = false
  default = "b1ghjq22lr63dgtqpu9l"
}

variable "folder_id" {
  description = "Yandex Cloud folder_id"
  type        = string
  sensitive = false
  default = "b1gehqihinh6cal2a9hq"
}

variable "image_id" {
  description = "Yandex Cloud image_idd"
  type        = string
  sensitive = false
  default = "fd87uq4tagjupcnm376a"
}