variable "bucket_name" {
    default = "my-s3-static"
  
}

variable "tags" {
    default = {
        Name="my-s3-static"
        Environment = "testing"
        terraform=true

    }
  
}