variable "env_id" {
  type        = string
  description = "enviroment for develoment"
  default     = "dev"
}
variable "subscription_id" {
  type        = string
  description = "azure description id"
  
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
}

variable "location" {
  description = "location 2 for azure"
  default = "East US 2"
}