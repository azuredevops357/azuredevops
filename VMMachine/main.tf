provider "google" {
  project     = "${var.project}"
  credentials = "${file("gcp-demo-330202-fd2f606acbaa.json")}"
}

provider "google-beta" {
  project     = "${var.project}"
  credentials = "${file("gcp-demo1-330603-faae72cd44b2.json")}"
}