# S3_CONFIG = YAML.load_file(Rails.root.join('config', 'aws.yml'))[Rails.env]
# 
# CarrierWave.configure do |config|
#   config.fog_credentials = {
#     provider: "AWS",
#     aws_access_key_id: S3_CONFIG["aws_access_key_id"],
#     aws_secret_access_key: S3_CONFIG["aws_secret_key"]
#   }
#   config.fog_directory = S3_CONFIG["aws_bucket"]
# end