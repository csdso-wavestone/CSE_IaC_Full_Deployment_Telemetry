variable "tenant_id" {
  type    = string
  default = "TENANT-ID-PLACEHOLDER" # modify accordingly
}

variable "subscription_id" {
  type    = string
  default = "SUBSCRIPTION-ID-PLACEHOLDER" # modify accordingly
}

variable "rg_name" {
  type    = string
  default = "sandbox_prenom.nom"
}

variable "location" {
  type    = string
  default = "France Central"
}

variable "deploy_vm" {
  type    = bool
  default = false
}
