resource "aws_lb" "myfirstloadbalancer" {
    name = "myfirstloadbalancer"
    internal = "false"
    ip_address_type = "ipv4"
    load_balancer_type = "application"
    security_groups = [ aws_security_group.loadbalancer_web.id ]
    subnets = [aws_subnet.subnet_us_east_2a.id, aws_subnet.subnet_us_east_2b.id, aws_subnet.subnet_us_east_2c.id ]

    tags = {
        "Name" = "myloadbalancer"
    }
}

resource "aws_lb_target_group" "target-group-1" {
    protocol = "HTTP"
    port = 80
    load_balancing_algorithm_type = "round_robin"
    slow_start = 0
    vpc_id = aws_vpc.main.id

    health_check {
        path = "/"
        healthy_threshold = 5
        interval = 30
        port = "traffic-port"
        protocol = "HTTP"
        timeout = 5
        unhealthy_threshold = 2
        matcher = 200        
    }

    tags = {
        "Name" = "target-group-1"
    }
}

resource "aws_lb_listener" "alb_web" {
    load_balancer_arn = aws_lb.myfirstloadbalancer.arn
    port = 80
    default_action {
        target_group_arn = aws_lb_target_group.target-group-1.arn
        type = "forward"
    }
  
}

resource "aws_lb_target_group_attachment" "web" {
    target_group_arn = aws_lb_target_group.target-group-1.arn
    target_id = aws_instance.elastic.id
    port = 80
}