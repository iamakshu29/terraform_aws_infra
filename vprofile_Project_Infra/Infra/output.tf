output "rmq_ip" {
  value = aws_instance.rmq_instance.private_ip
}

output "memcache_ip" {
  value = aws_instance.memcache_instance.private_ip
}

output "tomcat_ip" {
  value = aws_instance.tomcat_instance.private_ip
}

output "nginx_ip" {
  value = aws_instance.nginx_instance.private_ip
}

output "mysql_ip" {
  value = aws_instance.mysql_instance.private_ip
}