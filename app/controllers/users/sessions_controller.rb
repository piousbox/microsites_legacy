

class Users::SessionsController < Devise::SessionsController
  
  skip_authorization_check 

  def new
    if '1' == @is_mobile
      render :layout => 'organizer'

    else
      case @domain
      when 'organizer.local', 'organizer.annesque.com', 'qxt.local'
        render :layout => 'organizer'

      when 'mobi.local', 'travel-guide.mobi'
        render

      when 'ish.local', 'infiniteshelter.com'
        render :layout => 'application'

      when 'cac.local', 'computationalartscorp.com'
        render :layout => 'cac'

      when 'piousbox.com', 'pi.local'
        render :layout => 'organizer'

      else
        if @domain.include? 'blog'
          render :layout => 'blog'

        else
          render

        end
        
      end

    end
    
  end
  
end

