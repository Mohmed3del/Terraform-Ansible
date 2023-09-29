cat <<EOF > $HOME/.ssh/config
host bastion
   HostName $1
   User ubuntu
   IdentityFile $HOME/projects/Terraform_Ansible/keys/DevOps.pem
   StrictHostKeyChecking=no

host private1
   HostName  $2
   user  ubuntu
   IdentityFile $HOME/projects/Terraform_Ansible/keys/DevOps.pem
   ProxyCommand ssh bastion -W %h:%p
   StrictHostKeyChecking=no

host private2
   HostName  $3
   user  ubuntu
   IdentityFile $HOME/projects/Terraform_Ansible/keys/DevOps.pem
   ProxyCommand ssh bastion -W %h:%p
   StrictHostKeyChecking=no
EOF