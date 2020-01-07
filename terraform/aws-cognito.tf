module "cognito-user-pool" {
  source  = "./modules/cognito-user-pool/"
  user_pool_name = "bgshop-user-pool"
  alias_attributes         = ["email"]
  auto_verified_attributes = ["email"]

  admin_create_user_config = {
    unused_account_validity_days = 9
    email_subject                = "Here, your verification code baby"
  }

  email_configuration = {
    email_sending_account  = "COGNITO_DEFAULT"
    reply_to_email_address = ""
    source_arn             = ""
  }

  password_policy = {
    minimum_length    = 8
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }

  schemas = [
    {
      attribute_data_type      = "Boolean"
      developer_only_attribute = false
      mutable                  = true
      name                     = "available"
      required                 = false
    },
    {
      attribute_data_type      = "Boolean"
      developer_only_attribute = true
      mutable                  = true
      name                     = "registered"
      required                 = false
    }
  ]

  string_schemas = [
    {
      attribute_data_type      = "String"
      developer_only_attribute = false
      mutable                  = true
      name                     = "LinkedIn"
      required                 = false

      string_attribute_constraints = {
        min_length = 1
        max_length = 256
      }
    },
    {
      attribute_data_type      = "String"
      developer_only_attribute = false
      mutable                  = true
      name                     = "birthdate"
      required                 = true

      string_attribute_constraints = {
        min_length = 10
        max_length = 10
      }
    },
    {
      attribute_data_type      = "String"
      developer_only_attribute = false
      mutable                  = true
      name                     = "email"
      required                 = true

      string_attribute_constraints = {
        min_length = 3
        max_length = 2048
      }
    },
    {
      attribute_data_type      = "String"
      developer_only_attribute = false
      mutable                  = true
      name                     = "family_name"
      required                 = true

      string_attribute_constraints = {
        min_length = 0
        max_length = 2048
      }
    },
    {
      attribute_data_type      = "String"
      developer_only_attribute = false
      mutable                  = false
      name                     = "gender"
      required                 = true

      string_attribute_constraints = {
        min_length = 0
        max_length = 2048
      }
    },
    {
      attribute_data_type      = "String"
      developer_only_attribute = false
      mutable                  = true
      name                     = "given_name"
      required                 = true

      string_attribute_constraints = {
        min_length = 0
        max_length = 2048
      }
    },
    {
      attribute_data_type      = "String"
      developer_only_attribute = false
      mutable                  = true
      name                     = "phone_number"
      required                 = true

      string_attribute_constraints = {
        min_length = 0
        max_length = 2048
      }
    },
    {
      attribute_data_type      = "String"
      developer_only_attribute = false
      mutable                  = true
      name                     = "picture"
      required                 = true

      string_attribute_constraints = {
        min_length = 0
        max_length = 2048
      }
    },
      {
      attribute_data_type      = "String"
      developer_only_attribute = false
      mutable                  = true
      name                     = "preferred_username"
      required                 = true

      string_attribute_constraints = {
        min_length = 0
        max_length = 2048
      }
    }
  ]

    sms_authentication_message = "Your authentication code is {####}. "
    sms_configuration = {
                external_id = "c77cd8a8-c625-4fc4-affe-a85cc37f3a65"
                sns_caller_arn = "arn:aws:iam::439352748066:role/service-role/bgshopuserpool-SMS-Role"
              }
    sms_verification_message = "Your verification code is {####}. "

    verification_message_template = {
                default_email_option = "CONFIRM_WITH_LINK"
                email_message = "Your verification code is {####}. "
                email_message_by_link = "Please click the link below to verify your email address. {##Verify Email##} "
                email_subject = "Your verification code"
                email_subject_by_link = "Your verification link"
                sms_message = "Your verification code is {####}. "
              }
            

  tags = {
    Owner       = "pozi"
    Environment = "production"
    Terraform   = true
  }
}

resource "aws_cognito_user_pool_client" "client" {
  name = "bgshop-app-client"

  user_pool_id = module.cognito-user-pool.id
  supported_identity_providers = [
              "COGNITO"
            ]
}

resource "aws_cognito_user_pool_domain" "main" {
  domain       = "bgshop"
  user_pool_id = module.cognito-user-pool.id
}