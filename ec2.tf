# Cria a instância EC2
resource "aws_instance" "web_server" {
    ami           = data.aws_ami.amazon_linux.id
    instance_type = "t2.micro"
    user_data     = base64encode(file("user_data.sh"))

    # Define o key pair para a instância
    key_name      = aws_key_pair.ec2_key_pair.key_name

    # Associa os 3 Security Groups à instância
    vpc_security_group_ids = [
        aws_security_group.http_sg.id,
        aws_security_group.ssh_sg.id,
        aws_security_group.egress_all_sg.id
    ]

    tags = {
        Name = "WebServer-DVP"
    }
}
