
if 'production' == Rails.env || 'test' == Rails.env
  DOMAIN = 'piousbox.com'
elsif 'development' == Rails.env
  DOMAIN = 'pi.local'
end
