terraform {
    required_providers {
        google = {
            source = "hashicorp/google"
            version = "~> 7.12"
        }
        random = {
            source = "hashicorp/random"
            version = "~> 3.7"
        }
    }
}