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

variable "nickname" {
  type    = string
  default = "trigram" # Replace this by your trigram, e.g., jdo for "John Doe" in lower case
}

variable "deploy_vm" {
  type    = bool
  default = true
}
