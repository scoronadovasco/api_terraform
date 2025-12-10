variable "env_id" {
  type        = string
  description = "enviroment for develoment"
  default     = "dev"
}
variable "subscription_id" {
  type        = string
  description = "azure description id"
  default     = "ef0daded-79da-4cd0-ba63-e41e85e065d6"
}

variable "tags" {
  type = map(string)
  default = {
    "enviroment" = "DEV"
    "src"        = "terraform"
    "owner"      = "scoronado"
  }
}
