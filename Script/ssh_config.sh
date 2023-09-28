cat <<EOF > $HOME/.ssh/config
host bastion
   HostName $1
   User ubuntu
   StrictHostKeyChecking=no

host private1
   HostName  $2
   user  ubuntu
   ProxyCommand ssh bastion -W %h:%p
   StrictHostKeyChecking=no

host private2
   HostName  $3
   user  ubuntu
   ProxyCommand ssh bastion -W %h:%p
   StrictHostKeyChecking=no
EOF