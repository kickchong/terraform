{
    "Version": "2008-10-17",
    "Id": "PolicyForCloudFrontPrivateContent",
    "Statement": [
        {
            "Sid": "S3 Sync Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::122649790424:role/EC2-IAM-Role"
            },
            "Action": [
                "s3:GetObject",
                "s3:GetObjectAcl",
                "s3:PutObject",
                "s3:PutObjectAcl",
                "s3:DeleteObject"
            ],
            "Resource": "arn:aws:s3:::stamps-resources-production/img/*"
        },
        {
            "Sid": "Cross Account Bucket Permission",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::122649790424:root"
            },
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::stamps-resources-production"
        },
        {
            "Sid": "S3 Sync Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::122649790424:root"
            },
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::stamps-resources-production/*"
        },
        {
            "Sid": "S3 Sync Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::122649790424:role/provision_server_role"
            },
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::stamps-resources-production",
                "arn:aws:s3:::stamps-resources-production/*"
            ]
        }
    ]
}