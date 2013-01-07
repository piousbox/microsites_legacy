

class Users::SessionsController < Devise::SessionsController
  
  skip_authorization_check

  def new
    
    if 'application' == @layout
      render :layout => 'application'

    elsif 'organizer' == @layout
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
        render :layout => 'organizer'

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

