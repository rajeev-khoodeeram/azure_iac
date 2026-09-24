resource "azuread_group" "platform_admins" {
  display_name     = "Platform-Admins"
  security_enabled = true
}

resource "azuread_group" "security_admins" {
  display_name     = "Security-Admins"
  security_enabled = true
}

resource "azuread_group" "workload_developers" {
  display_name     = "Workload-Developers"
    security_enabled = true
  }

resource "azuread_group" "auditors" {
  display_name     = "Auditors"
  security_enabled = true
}