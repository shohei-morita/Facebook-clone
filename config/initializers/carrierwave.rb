CarrierWave.configure do |config|
  require 'carrierwave/storage/abstract'
  require 'carrierwave/storage/file'
  require 'carrierwave/storage/fog'
  config.storage :fog
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id:  ENV[""],
    aws_secret_access_key:  ENV[""],
    region: 'ap-northeast-1',
    path_style: true,
  }
  config.fog_public = true
  config.fog_attributes = {'Cache-Control' => 'public, mac-age=86400'}
  case Rails.env
  when 'production'
    config.fog_directory = ''
    config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/'
  when 'development'
    config.fog_directory = ''
    config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/'
  end
end
