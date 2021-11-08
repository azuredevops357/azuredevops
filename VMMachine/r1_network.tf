resource "google_compute_subnetwork" "public_subnet_r1" {
  name          =  "${format("%s","${var.company}-${var.env}-${var.region1}-pub-net")}"
  ip_cidr_range = "${var.r1_public_subnet}"
  network       = "${google_compute_network.vpc.name}"
  region        = "${var.region1}"
}
resource "google_compute_subnetwork" "private_subnet_r1" {
  name          =  "${format("%s","${var.company}-${var.env}-${var.region1}-pri-net")}"
  ip_cidr_range = "${var.r1_private_subnet}"
  network      = "${google_compute_network.vpc.name}"
  region        = "${var.region1}"
}