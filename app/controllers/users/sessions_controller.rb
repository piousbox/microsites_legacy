

class Users::SessionsController < Devise::SessionsController
  
  skip_authorization_check 

  def new
    case @domain
    when 'organizer.local', 'organizer.annesque.com'
      render :layout => 'organizer'

    when 'mobi.local', 'travel-guide.mobi'
      render

    when 'ish.local', 'infiniteshelter.com'
      render :layout => 'ish'

    when 'cac.local', 'computationalartscorp.com'
      render :layout => 'cac'

    when 'piousbox.com', 'pi.local'
      render :layout => 'resume'

    else
      if @domain.include? 'blog'
        render :layout => 'blog'

      else
        render

      end

    end
  end
  
end

