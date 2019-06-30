//-------------------------------------------------------------------
// VMware vsphere vCenter settings
//-------------------------------------------------------------------

variable "vsphere_user" {
    default = "usamimi-example-user"
}

variable "vsphere_password" {
    default = "usamimi-example-password"
}

# Set your Server (https connection address)
variable "vsphere_server" {
    default = "your-server-name-or-ip-address"
}
