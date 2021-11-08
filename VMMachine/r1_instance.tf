resource "google_compute_instance" "web_ssh_r1" {
  name = "${format("%s","${var.company}-${var.env}-${var.region1}-instance1")}"
  machine_type = "n1-standard-1"
  #zone         =   "${element(var.var_zones, count.index)}"
  zone = "${format("%s","${var.region1}-b")}"
  tags = [
    "ssh",
    "http"]
  boot_disk {
    initialize_params {
      image = "debian-9-stretch-v20190326"
    }
  }
  labels = {
    webserver = "true"
  }
  metadata = {
    startup-script = <<SCRIPT
        sudo yum -y install epel-release
        sudo yum -y install nginx
        export HOSTNAME=$(hostname | tr -d '\n')
        export PRIVATE_IP=$(curl -sf -H 'Metadata-Flavor:Google' http://metadata/computeMetadata/v1/instance/network-interfaces/0/ip | tr -d '\n')
        echo "Welcome to $HOSTNAME - $PRIVATE_IP" > /usr/share/nginx/www/index.html
        service nginx start
        SCRIPT
  }
  network_interface {
    subnetwork = "${google_compute_subnetwork.public_subnet_r1.name}"
    access_config {
      // Ephemeral IP
    }
  }
  scheduling {
    preemptible = true
    automatic_restart = false
  }
}