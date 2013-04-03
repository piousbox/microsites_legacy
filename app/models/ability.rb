
class Ability

  include CanCan::Ability

  def initialize(user)
    
    #
    # signed in user
    #
    unless user.blank?

      can [ :create, :index, :new, :search ], Addressbookitem
      can :manage, Addressbookitem do |a|
        a.user == user
      end

      can [ :create, :new, :index ], CitiesUser
      can :manage, CitiesUser do |cu|
        cu.user == user
      end
      
      can [ :set_city ], City

      can [ :new, :create ], Community

      can [ :new, :create, :search, :index ], Day
      can :manage, Day do |day|
        day.user == user
      end

      can [ :create, :new ], Gallery
      can [ :edit, :update ], Gallery do |g|
        g.user == user
      end

      can [ :upload, :driver, :set_profile_photo, :new_profile_photo ], Photo
      can [ :move, :edit, :update, :destroy, :show ], Photo do |photo|
        photo.user == user
      end
      can [ :show ], Photo do |photo|
        photo.viewer_ids.include? user.id || user == photo.user
      end

      can [ :new, :create, :search, :index ], Report
      can [ :edit, :update ], Report do |r|
        r.user == user
      end
      
      can [ :new, :create ], Tag
      can [ :manage ], Tag do |tag|
        tag.user == user
      end

      can [ :organizer, :account, :photos, :scratchpad, :new_profile, :create_profile ], User
      can [ :update ], User do |uu|
        uu == user
      end

      can [ :new, :create, :index ], Venue
      can [ :manage ], Venue do |venue|
        venue.user == user
      end
      can [ :show ], Venue do |venue|
        venue.is_public && !venue.is_trash
      end

      can [ :new, :create, :index ], Video
      can [ :show ], Video do |video|
        video.is_public && !video.is_trash
      end
      can [ :manage ], Video do |video|
        video.user == user
      end

      #
      # manager
      #
      if user[:group_id] <= 2
        
        can [ :manage ], Cac
        can [ :manage ], CitiesUser
        can [ :manage ], City
        can [ :manage ], Community
        can [ :manage ], Country
        can [ :manage ], Day
        can [ :manage ], Edge
        can [ :manage ], Event
        can [ :manage ], Feature
        can [ :manage ], Gallery
        can [ :manage ], Message
        can [ :manage ], Newsitem
        can [ :manage ], Node
        can [ :manage ], Photo
        can [ :manage ], Report
        can [ :manage ], Site
        can [ :manage ], Subscription
        can [ :manage ], Tag
        can [ :manage ], User
        can [ :manage ], UserProfile
        can [ :manage ], Venue
        can [ :manage ], Video
        can [ :manage ], Welcome

      end

      #
      # if admin
      #
      can :manage, :all do
        user.group_id.to_s == "1"
      end
        
    end
    
    user ||= User.new
    
    ###
    ### applies to all users
    ###

    can [ :show, :home, :news, :slider, :about, :services, :team, :contact, :portfolio, :privacy ], Cac
    
    can [ :profile, :index, :show, :map, :events, :galleries, :videos, 
      :reports, :people, :users, :venues, :places, :temp, :not_found ], City
    
    can [ :index, :search, :not_found, :set_show_style ], Gallery
    can [ :show ], Gallery do |g|
      g.is_public && !g.is_trash
    end

    can [ :create ], Message

    # has to be outside user auth b/c the uploading component is ajax.
    can [ :new, :create, :index, :do_upload, :not_found ], Photo
    can [ :show ], Photo do |photo|
      photo.is_public && !photo.is_trash
    end
    
    can [ :index, :search, :new, :create, :not_found ], Report
    can [ :show ], Report do |r|
      r.is_public && !r.is_trash
    end
    
    can [ :index, :search, :not_found ], Tag
    can [ :show ], Tag do |t|
      t.is_public && !t.is_trash
    end
    
    can [ :resume, :reports, :galleries, :report, :gallery,
      :sign_in, :sign_up, :sign_out, :logout,
      :index, :show, :not_found, :github, :about ], User
    can [ :report ], User do |r|
      r.is_public && !r.is_trash
    end

    can [ :index, :search, :not_found, :news ], Venue
    can [ :show ], Venue do |v|
      v.is_public && !v.is_trash
    end

    can [ :index, :not_found ], Video
    can [ :show ], Video do |video|
      video.is_public && !video.is_trash
    end

    can [ :set_locale, :home, :ish_home ], Welcome
    
  end
end

