
#networking
#vpc
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = var.vpc_name
  }

}

# frontend pvt_subnet
resource "aws_subnet" "frontend_pvt_1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.frontend_pvt_subnet_1_cidr_block
  availability_zone = var.subnet_1a_az

  tags = {
    Name = var.frontend_pvt_1_name
  }
}

resource "aws_subnet" "frontend_pvt_2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.frontend_pvt_subnet_2_cidr_block
  availability_zone = var.subnet_1b_az

  tags = {
    Name = var.frontend_pvt_2_name
  }
}




# lb public subnet 

resource "aws_subnet" "lb_public-1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.lb_public_subnet_1_cidr_block
  availability_zone = var.subnet_1a_az
  tags = {
    Name = var.lb_public_1_name
  }
}

resource "aws_subnet" "lb_public-2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.lb_public_subnet_2_cidr_block
  availability_zone = var.subnet_1b_az
  tags = {
    Name = var.lb_public_2_name
  }
}


# internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

# public route table 

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.vpc_name}-public-rt"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id

  }
}

# subnet route table association
resource "aws_route_table_association" "lb_public-1-assoc" {
  subnet_id      = aws_subnet.lb_public-1.id
  route_table_id = aws_route_table.public-rt.id
}
resource "aws_route_table_association" "lb_public-2-assoc" {
  subnet_id      = aws_subnet.lb_public-2.id
  route_table_id = aws_route_table.public-rt.id
}


# nat gateway
resource "aws_eip" "nat-eip" {
  tags = {
    Name = "${var.vpc_name}-nat-eip"
  }
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id     = aws_subnet.lb_public-1.id
  tags = {
    Name = "${var.vpc_name}-nat-gw"
  }
}

# private route table
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.vpc_name}-private-rt"
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }
}

#subnet route table associations


resource "aws_route_table_association" "frontend_private-1-assoc" {
  subnet_id      = aws_subnet.frontend_pvt_1.id
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_route_table_association" "frontend_private-2-assoc" {
  subnet_id      = aws_subnet.frontend_pvt_2.id
  route_table_id = aws_route_table.private-rt.id
}


# create jenkins sg
resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-sg"
  description = "Allow HTTP, HTTPS, Jenkins"
  vpc_id      = aws_vpc.vpc.id

  # HTTP
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidr
  }

  # HTTPS
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidr
  }

  # Jenkins
  ingress {
    description = "Jenkins"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidr
  }

  # SSH (important)
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidr
  }

  # Outbound allow all
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.allowed_ssh_cidr
  }

  tags = {
    Name = "jenkins-security-group"
  }
}
