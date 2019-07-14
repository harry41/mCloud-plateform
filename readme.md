#### Setup repository on local machine

**Requirements** :
  - Terraform v0.11.11
  - ansible

Before getting start make sure you have installed `Terraform v0.11.11` and `ansible`. Here we are using Terraform to create infrastructure on aws cloud. we will use ansible as configuration management tool. we will install required packages on linux machine and will deploy web applications.

#### Prerequisite

In order to authanticate aws we must have to set below variables..

```bash
export AWS_ACCESS_KEY_ID="AKIAICYOUREXAMPLE"
export AWS_SECRET_ACCESS_KEY="DfdfkDFFdfoiu/YoUREXAMleKeY"
```

##### Generate your ssh keys:
This key will use to access application server(private subnet)
```bash
ssh-keygen -f "test_deploy_key" -b 2048 -t rsa -N '' -C "harrythedevopsguy@gmail.com"
```


**OPTIONAL** : Here we have some other Optional variables.
You can modify values and set variables accordigly.

```bash
export TF_VAR_rds_username="dbmaster"
export TF_VAR_rds_password=TQEyUkNmB_3hfdnRPE4ETje6onvrG8
export TF_VAR_DB_INSTANCE_TYPE="db.t2.micro"
export TF_VAR_RDS_DB_ALLOCATED_STORAGE="8"
```

##### Let's Start

This is completely automated infrastructure. complete infrastructure will up and running with below commands.

```bash
git clone https://github.com/harry41/mCloud-plateform.git
cd mCloud-plateform/
# To initialized terraform
terraform init
# To test code and dry run.
terraform plan
# To create infrastructure on aws cloud.
terraform apply
```

Once your infrastructure successfully created on aws. you just need to gether required below required info.

- NAT_SERVER_PUBLIC_IP :
- APP_SERVER_PRIVATE_IP :
- LOAD_BALANCER_ENDPOINT :

run below commands to access your server.

```bash
# TO Generate SSH_CONFIG file
./secrets/ssh_config_generator.sh NAT_SERVER_PUBLIC_IP
# To Access private ec2 instance
ssh -F secrets/ssh_config APP_SERVER_PRIVATE_IP
```



#### Application Deployment

grep  **`APP_SERVER_PRIVATE_IP`**  and update ansible hosts file `ansible/hosts/hosts` replace old ip with new private ip.

```bash
cd ansible
# To ping private host
ansible-playbook test.yml
# To deploy hello world django application
ansible-playbook python-project.yml
```
if above ansible playbook executed successfully. it means you have deployed a secure infrastructure on aws cloud. now it's time to access site url (LOAD_BALANCER_ENDPOINT).

#### let's see magic

if you have followed above steps correctly your application should be up and running very securely.

  Just hit **LOAD_BALANCER_ENDPOINT** in your browser.

    Note - You can map this LOAD_BALANCER_ENDPOINT with your domain.

---
Thanks<br>
Hari Prasad
