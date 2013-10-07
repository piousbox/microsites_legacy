if Rails.env == "production" 
  S3_CREDENTIALS = { 
    :access_key_id => "AKIAICS67L3FUORLSA7A", 
    :secret_access_key => "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", 
    :bucket => "ISh-development"
  }
elsif Rails.env == 'test'
  S3_CREDENTIALS = { 
    :access_key_id => "AKIAICS67L3FUORLSA7A", 
    :secret_access_key => "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", 
    :bucket => "ISh-test"
  }
else
  S3_CREDENTIALS = { 
    :access_key_id => "AKIAICS67L3FUORLSA7A", 
    :secret_access_key => "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", 
    :bucket => "ISh-trashy"
  }
end


