variable "usamimi-linux" {
    default = {
        VM_name = "usamimi-linux"

        vcpus   = "2"
        memory  = "2048"
        ipv4_address="192.168.1.1"
        ipv4_netmask="24"
        ipv4_gateway="192.168.1.254"
    }
}


resource "vsphere_virtual_machine" "usamimi-linux" {
  name                      = "${lookup(var.usamimi-linux,"VM_name")}"
  resource_pool_id          = "${data.vsphere_resource_pool.pool.id}"
  datastore_id              = "${data.vsphere_datastore.datastore.id}"

  num_cpus                  = "${lookup(var.usamimi-linux,"vcpus")}"
  memory                    = "${lookup(var.usamimi-linux,"memory")}"
  guest_id                  = "otherLinux64Guest"

  network_interface {
    network_id              =   "${data.vsphere_network.network.id}"
    adapter_type            =   "${data.vsphere_virtual_machine.linux-template.network_interface_types[0]}"
  }


  disk {
    label                   = "${lookup(var.usamimi-linux,"VM_name")}_disk"
    size                    = "${data.vsphere_virtual_machine.linux-template.disks.0.size}"
    eagerly_scrub           = "${data.vsphere_virtual_machine.linux-template.disks.0.eagerly_scrub}"
    thin_provisioned        = "${data.vsphere_virtual_machine.linux-template.disks.0.thin_provisioned}"
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.linux-template.id}"

   customize {

     linux_options {
       host_name        = "${lookup(var.usamimi-linux,"VM_name")}"
       domain           = "localhost.localdomain"
      }

      network_interface {
        ipv4_address    = "${lookup(var.usamimi-linux,"ipv4_address")}"
        ipv4_netmask    = "${lookup(var.usamimi-linux,"ipv4_netmask")}"
        }

      ipv4_gateway    = "${lookup(var.usamimi-linux,"ipv4_gateway")}"
    }
  }
}
