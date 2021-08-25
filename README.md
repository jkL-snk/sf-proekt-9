# Webinar homework

## Practice task: learn how to make a pipeline to automate deployment to different project environments.

### Task 12.1
Create a VM with Jenkins CI installed and two another vms that will emulate production and staging environments.

### Task 12.2
Use Ansible to deploy vms: all three machines to be deployed using ansible playbook.

### Task 12.3
Install Docker on all VMs. The Jenkins VM should be able to run docker containers under jenkins user.

### Task 12.4
Jenkins vm should be able to connect via ssh to product and staging environment vsm. Key distribution preferrably should be included in the playbook.

### Task 12.5
After all 3 vms are deployed create 5 jobs in Jenkins:

Run Wordpress containder on staging VM.
Run Wordpress containder on production VM.
Job with scheduled task that each 5 minutes pings prod and staging vms.
Job that gets uptime info from prod and staging vms.
Job that reboots prod or staging vms or both (depends on arguments).

## Solution:

Change public key in terraform/meta.yml

```
git clone https://github.com/jkL-snk/sf-pract-12-webinar.git
cd ./sf-pract-12-webinar/terraform
terraform init
terraform apply
```

Write external ips from terrafrom output to ansible/inventory.ini

```
cd ..
cd ansible
ssh-agent bash
ssh-add ~/.ssh/id_rsa
ansible-playbook ssh.yaml -i inventory.ini
ansible-playbook docker.yaml -i inventory.ini
ansible-playbook jenkins.yaml -i inventory.ini
ansible-playbook reboot.yaml -i inventory.ini
```

Write password from output into jenkins/jobs/import.sh (you can get in again by running ansible jenkins -i inventory.ini -a 'cat /var/lib/jenkins/secrets/initialAdminPassword' -b

```
cd jenkins/jobs/
./import.sh
```

Use the password to login into Jenkins web interface

Jobs will be available under names Job{1..5}
