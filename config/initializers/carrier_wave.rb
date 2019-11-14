if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Amazon S3用の設定
      :provider              => 'AWS',
      :region                => ENV['ap-northeast-1'],     # 例: 'ap-northeast-1'
      :aws_access_key_id     => ENV['AKIA6NQRFTM3LLKDEFGW'],
      :aws_secret_access_key => ENV['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']
    }
    config.fog_directory     =  ENV['test-access-test']
  end
end