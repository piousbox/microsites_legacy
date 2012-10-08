
module CacHelper
  
  def current_user
    { :id => 2 }
  end
  
  def image_contact
    image_tag 'http://s3.amazonaws.com/ish-assets/contact.png', :class => :contact
  end
  
end
