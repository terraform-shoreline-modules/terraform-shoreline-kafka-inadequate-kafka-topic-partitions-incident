terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "inadequate_kafka_topic_partitions_incident" {
  source    = "./modules/inadequate_kafka_topic_partitions_incident"

  providers = {
    shoreline = shoreline
  }
}