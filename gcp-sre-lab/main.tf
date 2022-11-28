module "sre" {
  source        = "terraform-google-modules/network/google"
  version       = "~> 3.0"
  project_id    = var.project_id
  network_name  = var.name
  subnets = [
      {
          subnet_name           = "subnet-${var.name}"
          subnet_ip             = "10.1.0.0/20"
          subnet_region         = var.region
          subnet_private_access = "true"
          subnet_flow_logs      = "true"
          subnet_flow_logs_intrtval  = "INTERVAL_15_MIN"
          subnet_flow_logs_samling   = 0.5
          subnet_flow_logs_meatadata = "EXCLUDE_ALL_METADATA"
      },
      {
          subnet_name           = "subnet-lab-1"
          subnet_ip             = "10.4.0.0/20"
          subnet_region         = var.region
          subnet_private_access = "true"
          subnet_flow_logs      = "true"
          subnet_flow_logs_intrtval  = "INTERVAL_15_MIN"
          subnet_flow_logs_samling   = 0.5
          subnet_flow_logs_meatadata = "EXCLUDE_ALL_METADATA"
      },
  ]
  secondary_ranges = {
      "subnet-${var.name}" = [
          {
              range_name    = "sre-ip-pods"
              ip_cidr_range = "10.2.0.0/16"
          },
          {
              range_name    = "sre-ip-svc"
              ip_cidr_range = "10.3.0.0/20"
          }
      ]
      "subnet-lab-1" = [
          {
              range_name    = "lab-1-ip-pods"
              ip_cidr_range = "10.5.0.0/16"
          },
          {
              range_name    = "lab-1-ip-svc"
              ip_cidr_range = "10.6.0.0/20"
          }
      ]
  }
}