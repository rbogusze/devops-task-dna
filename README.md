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

What is about to happen with terraform is that we will run a docker image as set in `variables.tf` file under `app_image` variable, which is currently set to `remik/remik_node:green`. That image is stored in public docker hub repository and we could first try to run it locally like:

    $ docker run --rm -p 80:8080 remik/remik_node:green

And check the results by checking http://localhost/

What terraform does is that it runs the same image in ECS and additionally creates and alias in the `boguszewicz.net` domain that points to load balancer that is configured in front of ECS.

Actual terraform execution
```
$ terraform init
$ terraform plan
$ terraform apply
-> and the magic happens
```

Two domains with different endpoints are provided:

http://boguszewicz.net - which goes to load balancer in front of ECS (dynamic, hits our docker every time)

http://www.boguszewicz.net - which goes to cloudfront cache, backed by load balancer (static, cache)

Page displays a visits counter which nicely shows if we see the live version or cache.

When all testing is done do the clenup

    $ terraform destroy

