#### Generate New ssh keys for your Application.

```bash
Syntax:
ssh-keygen -f "{project_name}_deploy_key" -b 2048 -t rsa -N '' -C "{your_email}"

example :

ssh-keygen -f "test_deploy_key" -b 2048 -t rsa -N '' -C "harrythedevopsguy@gmail.com"
```
