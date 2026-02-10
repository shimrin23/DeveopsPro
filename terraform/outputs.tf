output "app_server_public_ip" {
  description = "Public IP of Application Server"
  value       = aws_eip.app_eip.public_ip
}

output "app_server_private_ip" {
  description = "Private IP of Application Server"
  value       = aws_instance.app_server.private_ip
}

output "jenkins_server_public_ip" {
  description = "Public IP of Jenkins Server"
  value       = var.enable_jenkins ? aws_eip.jenkins_eip[0].public_ip : "Not created"
}

output "jenkins_url" {
  description = "Jenkins Web UI URL"
  value       = var.enable_jenkins ? "http://${aws_eip.jenkins_eip[0].public_ip}:8080" : "Not created"
}

output "frontend_url" {
  description = "Frontend Application URL"
  value       = "http://${aws_eip.app_eip.public_ip}:3000"
}

output "backend_url" {
  description = "Backend API URL"
  value       = "http://${aws_eip.app_eip.public_ip}:5001"
}

output "ssh_command_app" {
  description = "SSH command for Application Server"
  value       = "ssh -i ${var.key_name}.pem ubuntu@${aws_eip.app_eip.public_ip}"
}

output "ssh_command_jenkins" {
  description = "SSH command for Jenkins Server"
  value       = var.enable_jenkins ? "ssh -i ${var.key_name}.pem ubuntu@${aws_eip.jenkins_eip[0].public_ip}" : "Not created"
}

output "docker_compose_command" {
  description = "Command to deploy application"
  value       = "Update REACT_APP_SERVER_DOMAIN to http://${aws_eip.app_eip.public_ip}:5001/api and run: docker-compose up -d"
}
