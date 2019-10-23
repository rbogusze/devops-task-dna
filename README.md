# How to run this

First set AWS credentials so that terraform can use them without explicitly providing in the configuration files or even exporting as env variables.

```
$ aws configure --profile testing
    AWS Access Key ID [****************]:
    AWS Secret Access Key [****************]:
    Default region name [eu-west-1]:
    Default output format [json]:
```

Then export the name of the AWS profile

    $ export AWS_PROFILE=testing

Run a simple check to make sure it is working. One can expect the below output if no EC2 instances are setup.
```
$ aws ec2 describe-instances
{
    "Reservations": []
}
```

Actual terraform execution
```
$ terraform init
$ terraform plan
$ terraform apply
-> and the magic happens
```

Now the http://boguszewicz.net should be reachable.

When all testing is done do the clenup

    $ terraform destroy




