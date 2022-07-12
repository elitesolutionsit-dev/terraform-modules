locals {
  # Common tags to be assigned to all resources
  database_tags = {
    Service     = "devOps"
    Owner       = "elitesolutionsit"
    environment = "Development"
    ManagedWith = "terraform"
  }
  server      = var.server
  buildregion = var.buildregion
}