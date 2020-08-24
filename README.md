# Terraform AWS EC2 for Docker Compose

> This repository contains Terraform code that uses the [AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs) to build an [AWS EC2](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts.html) instance using [Docker Compose](https://docs.docker.com/compose/) to launch [WordPress](https://wordpress.org/).

## Table of Contents

- [Terraform AWS EC2](#terraform-aws-ec2)
  - [Table of Contents](#table-of-contents)
  - [Tools](#tools)
  - [Usage](#usage)
  - [Notes](#notes)
  - [Author Information](#author-information)
  - [License](#license)

## Tools

- Local:
  - [tfenv install latest](https://github.com/tfutils/tfenv)
  - [terraform fmt](https://www.terraform.io/docs/commands/fmt.html)
  - [terraform validate](https://www.terraform.io/docs/commands/validate.html)
  - [TFLint](https://github.com/terraform-linters/tflint)
  - [pre-commit](https://pre-commit.com)
- Remote:
  - [Docker Enginer](https://docs.docker.com/engine/)
  - [Docker Compose](https://docs.docker.com/compose/)

## Usage

If you want to override the default variables in [variables.tf](https://github.com/nickkadams/wp-docker-demo/blob/main/variables.tf), copy [terraform.tfvars.sample](https://github.com/nickkadams/wp-docker-demo/blob/main/terraform.tfvars.sample) to `terraform.tfvars` and fill in your specific information.

1. Initialize the Terraform directory (`.terraform/`) by running `terraform init`
1. Create the Terraform execution plan by running `terraform plan`
1. If everything looks correct, you can apply the Terraform changes by running `terraform apply` and typing `yes` when prompted.
1. From your web browser, access the public_ip displayed from the successful terraform apply to finish configuring [WordPress](https://wordpress.org/support/article/how-to-install-wordpress/#setup-configuration-file).  
1. If this is *NOT* production and you are finished testing, you can destroy the infrastructure by running `terraform destroy` and typing `yes` when prompted.

### Optional - RDS Multi-AZ MySQL

1. `cd rds`
1. `terraform init`
1. `terraform plan`
1. `terraform apply`
1. You can find your randomly generated [RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Welcome.html) password encrypted in [Systems Manager > Parameter Store](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-parameter-store.html).

## Notes

- For HTTPS see [Let's Encrypt with Docker](https://medium.com/@pentacent/nginx-and-lets-encrypt-with-docker-in-less-than-5-minutes-b4b8a60d3a71)
- The default AWS Security Group restricts SSH/HTTP/HTTPS to your ISP's address. You can change that in [sg.tf](https://github.com/nickkadams/wp-docker-demo/blob/main/sg.tf)
- This is by no means a production grade, high availability (HA) deployment of [WordPress](https://wordpress.org/). To achieve that outcome, I would look at a reference architectures such as [ECS](https://dev.to/saluminati/high-traffic-wordpress-website-with-docker-aws-ecs-code-pipeline-load-balancer-rds-efs-complete-series-43id) or [EKS](https://kubernetes.io/docs/tutorials/stateful-application/mysql-wordpress-persistent-volume/) and codify the additional Terraform resources.
- Thank you to [ksatirli](https://github.com/ksatirli/code-quality-for-terraform) for the Terraform linting best practices.

## Author Information

This repository is maintained by [Nick Adams](https://github.com/nickkadams).

## License

Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an _"AS IS"_ basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
