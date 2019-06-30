provider "vsphere" {
    user           = "${var.vsphere_user}"
    password       = "${var.vsphere_password}"
    vsphere_server = "${var.vsphere_server}"
    allow_unverified_ssl  = true
}

data "vsphere_datacenter" "dc" {
  name = "Datacenter"
}


data "vsphere_datastore" "datastore" {
  name          = "datastore-cluster/datastore1"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}


data "vsphere_resource_pool" "pool" {
  name          = "Usamimi/Usamimi-RP"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
