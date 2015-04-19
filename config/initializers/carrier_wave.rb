CarrierWave.configure do |config|
  config.storage    = :aws
  config.aws_bucket = ENV.fetch('BUCKET')
  config.aws_acl    = :public_read
  config.aws_authenticated_url_expiration = 60 * 60 * 24 * 365

  config.aws_credentials = {
    access_key_id:     ENV.fetch('AWSKEYID'),
    secret_access_key: ENV.fetch('AWSKEYACCESS')
  }
end
