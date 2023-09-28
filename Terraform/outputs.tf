output "eip" {
  value = module.network.e_ip

}
output "natg" {
  value = module.network.nat

}



output "my_public_ip" {
  value = data.http.myip.response_body
}

output "load_balancer_dns" {
  value = module.Load_Balancer.load_balancers["public"].dns_name
  
}