variable "usamimi-windows" {
    default = {
        VM_name = "usamimi-windows"

        vcpus   = "2"
        memory  = "4096"
        ipv4_address="192.168.1.200"
        ipv4_netmask="24"
        ipv4_gateway="192.168.1.254"
    }
}


resource "vsphere_virtual_machine" "usamimi-windows" {
  name                        = "${lookup(var.usamimi-windows,"VM_name")}"
  resource_pool_id            = "${data.vsphere_resource_pool.pool.id}"
  datastore_id                = "${data.vsphere_datastore.datastore.id}"

  num_cpus                    = "${lookup(var.usamimi-windows,"vcpus")}"
  memory                      = "${lookup(var.usamimi-windows,"memory")}"
  guest_id                    = "windows9_64Guest"

  network_interface {
    network_id                =   "${data.vsphere_network.network.id}"
    adapter_type              =   "${data.vsphere_virtual_machine.windows-template.network_interface_types[0]}"
  }


  disk {
    label                     = "${lookup(var.usamimi-windows,"VM_name")}_disk"
    size                      = "${data.vsphere_virtual_machine.windows-template.disks.0.size}"
    eagerly_scrub             = "${data.vsphere_virtual_machine.windows-template.disks.0.eagerly_scrub}"
    thin_provisioned          = "${data.vsphere_virtual_machine.windows-template.disks.0.thin_provisioned}"
  }

  clone {
   template_uuid             = "${data.vsphere_virtual_machine.windows-template.id}"

   customize {

      windows_options {
        computer_name         = "${lookup(var.usamimi-windows,"VM_name")}-Clone"
        workgroup             = "WORKSTATION"
        full_name             = "usamimi-windows"
        admin_password        = "password"
        
        #product_key           = ""

        # #If you use domain (Active Directory) modify under.
        #domain_admin_user     = ""
        #domain_admin_password = ""
      }

      network_interface {
        ipv4_address    = "${lookup(var.cusamimi-windows,"ipv4_address")}"
        ipv4_netmask    = "${lookup(var.usamimi-windows,"ipv4_netmask")}"
        }

      ipv4_gateway    = "${lookup(var.usamimi-windows,"ipv4_gateway")}"
    }
  }
}

