// all networking resources like VPC, subnets, internet gateway, route tables

// Internet Gateway (IGW)
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "project-bedrock-igw"
  }
}

/*
Gives your public subnets access to the internet.

aws_vpc.main.id references the VPC you defined in main.tf
*/

// Route Table for Public Subnets

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "project-bedrock-public-rt"
  }
}
// Route to IGW for internet access
// Creates a route table to define where traffic goes for the public subnets.

// 3. Route to the Internet

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}


/*Sends all traffic (0.0.0.0/0) from public subnets through the IGW to reach the internet.*/

// 4. Associate Public Subnets with Route Table

resource "aws_route_table_association" "public_assoc" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

/*
Links your public subnets to the route table.

Uses count to handle multiple subnets automatically.
*/

/*✅ Summary:

This code defines how your public subnets can access the internet.

Put it in network.tf.

Later, you’ll add NAT Gateway + private subnet routes for your EKS nodes and private services.
*/