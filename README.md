### Packer Ubuntu 16.04 with Docker and Docker Compose

Packer template for provisioning an EC2 instance on AWS with Docker and Docker Compose

## Usage
```packer build -var 'aws_access_key=<aws_access_key>' -var 'aws_secret_key=<aws_secret_key>' template-aws.json```

## License

The MIT License (MIT). Please see [License File](LICENSE.md) for more information.