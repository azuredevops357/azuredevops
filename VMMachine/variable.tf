variable "project" {
        default = "gcp-project-id"
    }
variable "region1" {
        default = "us-west2"
}
variable "region2" {
        default = "us-central1"
}
variable "env" {
        default = "dev"
    }
variable "company" {
        default = "akiatoji"
    }
variable "r1_private_subnet" {
        default = "10.26.1.0/24"
    }
variable "r1_public_subnet" {
        default = "10.26.2.0/24"
    }
variable "r2_private_subnet" {
        default = "10.28.1.0/24"
    }
variable "r2_public_subnet" {
        default = "10.28.2.0/24"
    }