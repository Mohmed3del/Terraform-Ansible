cat <<EOF > $HOME/.ssh/config
host bastion1
   HostName $1
   User ubuntu
   IdentityFile $HOME/projects/Terraform_Ansible/keys/DevOps.pem
   StrictHostKeyChecking=no

host private1
   HostName  $2
   user  ubuntu
   IdentityFile $HOME/projects/Terraform_Ansible/keys/DevOps.pem
   ProxyCommand ssh -q -W %%h:%%p  bastion1
   StrictHostKeyChecking=no

host private2
   HostName  $3
   user  ubuntu
   IdentityFile $HOME/projects/Terraform_Ansible/keys/DevOps.pem
   ProxyCommand ssh -q -W %%h:%%p  bastion1
   StrictHostKeyChecking=no
EOF