# Terraform configuration file to create
# the pre-requisites for kops on AWS

resource "aws_iam_user" "kops" {
	name				= "kops"
}

resource "aws_iam_access_key" "kops" {
	user				= "${aws_iam_user.kops.name}"
}

resource "aws_iam_user_policy_attachment" "kops_mgd_pol_1" {
	user				= "${aws_iam_user.kops.name}"
	policy_arn	= "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_user_policy_attachment" "kops_mgd_pol_2" {
	user        = "${aws_iam_user.kops.name}"
	policy_arn	= "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
}

resource "aws_iam_user_policy_attachment" "kops_mgd_pol_3" {
	user				= "${aws_iam_user.kops.name}"
	policy_arn  = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_user_policy_attachment" "kops_mgd_pol_4" {
	user        = "${aws_iam_user.kops.name}"
	policy_arn  = "arn:aws:iam::aws:policy/IAMFullAccess"
}

resource "aws_iam_user_policy_attachment" "kops_mgd_pol_5" {
	user        = "${aws_iam_user.kops.name}"
	policy_arn  = "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
}

resource "aws_s3_bucket" "kops_config_bucket" {
	bucket			= "{my_bucket_name}"
	acl					=	 "private"

	versioning {
		enabled = true
	}

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

	tags {
		Name    = "kops Cluster Configuration Bucket"
	}
}

resource "aws_s3_bucket_policy" "b" {
	bucket			= "${aws_s3_bucket.kops_config_bucket.id}"
	policy			=<<POLICY
{
	"Version": "2012-10-17",
	"Statement": [
		{
				"Sid": "Allow kops user access to k8s cluster configuration bucket",
				"Effect": "Allow",
				"Principal": {
						"AWS": [
								"${aws_iam_user.kops.arn}"
						]
				},
				"Action": [
						"s3:GetBucketLocation",
						"s3:ListBucket",
						"s3:GetObject",
						"s3:PutObject"
				],
				"Resource": [
						"${aws_s3_bucket.kops_config_bucket.arn}",
						"${aws_s3_bucket.kops_config_bucket.arn}/*"
				]
		}
	]
}
POLICY

}

resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket      = "{my_tf_bucket_name}"
  acl         =  "private"

  versioning {
    enabled = true
  }

	server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags {
    Name    = "Terraform State Bucket"
  }
}

resource "aws_s3_bucket_policy" "b" {
  bucket      = "${aws_s3_bucket.terraform_state_bucket.id}"
  policy      =<<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Sid": "Allow kops user access to k8s cluster configuration bucket",
        "Effect": "Allow",
        "Principal": {
            "AWS": [
                "${aws_iam_user.kops.arn}"
            ]
        },
        "Action": [
            "s3:GetBucketLocation",
            "s3:ListBucket",
            "s3:GetObject",
            "s3:PutObject"
        ],
        "Resource": [
            "${aws_s3_bucket.terraform_state_bucket.arn}",
            "${aws_s3_bucket.terraform_state_bucket.arn}/*"
        ]
    }
  ]
}
POLICY

}
