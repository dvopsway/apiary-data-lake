/**
 * Copyright (C) 2018 Expedia Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */

resource "aws_iam_role_policy" "rds_for_ecs_readonly" {
  count = "${ var.external_database_host == "" ? 1 : 0 }"
  name  = "rds"
  role  = "${aws_iam_role.apiary_task_readonly.id}"

  policy = <<EOF
{
   "Version" : "2012-10-17",
   "Statement" :
   [
     {
       "Effect" : "Allow",
       "Action" : ["rds-db:connect"],
       "Resource" : ["arn:aws:rds-db:${var.aws_region}:${data.aws_caller_identity.current.account_id}:dbuser:${aws_rds_cluster.apiary_cluster.cluster_resource_id}/iamro"]
     }
   ]
}
EOF
}

resource "aws_iam_role_policy" "rds_for_ecs_task_readwrite" {
  count = "${ var.external_database_host == "" ? 1 : 0 }"
  name  = "rds"
  role  = "${aws_iam_role.apiary_task_readwrite.id}"

  policy = <<EOF
{
   "Version" : "2012-10-17",
   "Statement" :
   [
     {
       "Effect" : "Allow",
       "Action" : ["rds-db:connect"],
       "Resource" : ["arn:aws:rds-db:${var.aws_region}:${data.aws_caller_identity.current.account_id}:dbuser:${aws_rds_cluster.apiary_cluster.cluster_resource_id}/iamrw"]
     }
   ]
}
EOF
}
