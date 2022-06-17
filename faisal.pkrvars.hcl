owner      = "faisal"
aws_region = "us-east-1"
repo       = "faisalcodesinfrastructure/packer-cal2-java"
# Base image we are leveraging
base_image_bucket_name = "cis-amazon-linux-2"
base_image_channel     = "dev"
aws_instance_type  = "c3.large"
# Image we are creating
bucket_name        = "java-golden-image-cal2"
bucket_description = "This is the Java golden image."
