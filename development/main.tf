terraform {
  backend "s3" {
    bucket         = "tdr-prototype-terraform-state"
    key            = "prototype-terraform/stateful/dev/terraform.tfstate"
    region         = "eu-west-2"
    encrypt        = true
    dynamodb_table = "terraform-statelock-tdr-prototype"
  }
}

provider "aws" {
  region = var.region
}

module "cognito" {

  source = "git::https://github.com/nationalarchives/tdr-prototype-terraform-modules.git//cognito?ref=development"
  //SSH Alternative: "git@github.com:nationalarchives/tdr-prototype-terraform-modules.git//cognito?ref=development"

  cognito_user_pool = "${var.tag_prefix}-${var.enviroment}"
  tag_name          = "${var.tag_prefix}-authentication-${var.enviroment}-userpool1"
  environment       = var.enviroment
}