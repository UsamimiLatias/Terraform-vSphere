data "vsphere_virtual_machine" "linux-template" {
  name          = "usamimi-linux"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}


data "vsphere_virtual_machine" "windows-template" {
  name          = "usamimi-windows"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
