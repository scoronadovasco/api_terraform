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


variable "userdb" {
  type = string
  default = "scoronado"
}
variable "userdbpass" {
  type      = string
  sensitive = true
  default = "Ac6f1cf3.123.."
}

variable "location" {
  description = "location 2 for azure"
  default = "East US 2"
}