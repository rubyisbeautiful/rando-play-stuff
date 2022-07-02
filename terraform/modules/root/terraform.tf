terraform {
  # use a real backend
  backend "local" {}
}

module "foo" {
  source = "../stuff"
}
