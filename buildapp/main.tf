provider "aws" {
  profile = "default"
  region = "us-west-2"
}

resource "aws_s3_bucket" "tf_course" {
  bucket = "tf-test-25042021hh"
  acl = "private"
}

module "cbuild" {
  source = "git::https://github.com/tmknom/terraform-aws-codebuild.git"
   name   = "example"
 # artifact_bucket_arn = var.artifact_bucket_arn
  environment_type    = "LINUX_CONTAINER"
  compute_type        = "BUILD_GENERAL1_MEDIUM"
  image               = "aws/codebuild/docker:18.09.0"
  privileged_mode     = true
 # buildspec           = "configuration/buildspec.yml"
  cache_type          = "S3"
 # cache_location      = "${aws_s3_bucket.artifact.id}/codebuild"
  encryption_key      = ""
  build_timeout       = 10
  iam_path            = "/service-role/"
  description         = "This is example"
  enabled_ecr_access    = true
  ecr_access_policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
  build_stages =   [{

          stage_name = "app1"
          repository ="https://github.com/marianars/test_codebuild.git"
          working_bucket=""
          source_version = "feature/Mariana"
          buildspec = "buildapp/app1.yml" 
      }
  ]
}


