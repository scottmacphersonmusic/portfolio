CarrierWave.configure do |config|
  require 'fog/aws'

  config.fog_credentials = {
    provider: "AWS",
    aws_access_key_id: ENV["AWSAccessKeyId"],
    aws_secret_access_key: ENV["AWSSecretAccessKey"],
    region: 'us-west-2',
  }
  config.fog_directory = ENV["AWS_S3_BUCKET"]
end
