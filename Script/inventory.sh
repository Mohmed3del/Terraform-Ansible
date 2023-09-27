cat <<EOF > ../Ansible/inventory
[bastion]
bastion1 ansible_host=$1
bastion2 ansible_host=$2

[private_ec2]
private1 ansible_host=$3
private2 ansible_host=$4

[private_ec2:vars]
application_dns=$5

EOF