terraform {
  cloud {
    organization = "craigsloggett-lab"

    workspaces {
      project = "Modules"
      name    = "terraform-aws-elasticache"
    }
  }
}
