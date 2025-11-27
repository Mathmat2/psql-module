# Module for Cloud SQL Postgres Instance
## Description
Module used to deploy a Cloud SQL Instance to GCP using Postgresql engine
## Usage exemple
```terraform
module "sql_instance" {
    source      = "../psql-module"
    project_id  = "prj-myproject"
    region      = "europe-west1"
    name        = "sql-instance"
    kms_key     = "projects/prj-myproject/locations/europe-west1/keyRings/kms-keys
    /cryptoKeys/my-key"
    vpc         = "my-vpc"
}
```