# resource "aws_ebs_volume" "elastic_logs" {
#   availability_zone = "us-east-2b"
#   size              = 20

#   tags = {
#     Name = "elastic"
#   }
# }

# resource "aws_volume_attachment" "elastic_att" {
#   device_name = "/dev/xvdf"
#   volume_id   = aws_ebs_volume.elastic_logs.id
#   instance_id = aws_instance.elastic2.id
# }

# resource "aws_ebs_volume" "elastic_logs_2" {
#   availability_zone = "us-east-2b"
#   size              = 20

#   tags = {
#     Name = "elastic"
#   }
# }

# resource "aws_volume_attachment" "elastic2_att" {
#   device_name = "/dev/xvdf"
#   volume_id   = aws_ebs_volume.elastic_logs_2.id
#   instance_id = aws_instance.elastic.id
# }
