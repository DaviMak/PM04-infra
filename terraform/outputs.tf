output "instance_ips" {
  description = "IP do contêiner Docker de cada VM (acessível pela rede interna)"
  value       = { for k, v in aws_instance.vm : k => v.public_ip }
}

output "instance_ids" {
  value = { for k, v in aws_instance.vm : k => v.id }
}