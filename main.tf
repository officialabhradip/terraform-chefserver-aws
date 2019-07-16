provider "aws {
access_key = ""
secret_key = ""
region = "ap-southeast-1"
}

resource "aws_instance" "chefserver" {
ami = "ami-04613ff1fdcd2eab1"
instance_type = "t2.medium"
root_block_device{
volume_size = "50"
}
provisioner "remote-exec" {
    inline = [
        "sudo cd /root"
        "sudo wget https://packages.chef.io/files/stable/chef-server/12.17.33/ubuntu/16.04/chef-server-core_12.17.33-1_amd64.deb -O /root/chefserver.deb"
        "sudo dpkg -i /root/chefserver.deb"
        "sudo chef-server-ctl reconfigure"
        "sudo chef-server-ctl user-create chefuser Chef User chefuser@chef.io 'chefuser123' --filename ~/chefuser.pem"
        "sudo wget https://packages.chef.io/files/stable/chef-manage/2.5.16/ubuntu/16.04/chef-manage_2.5.16-1_amd64.deb -O /root/chefmanage.deb"
        "sudo dpkg -i /root/chefmanage.deb"
        "sudo chef-server-ctl reconfigure"
        "sudo chef-manage-ctl reconfigure --accept-license"
        "sudo chef-server-ctl reconfigure"
    ]
  }
  
}
