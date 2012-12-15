


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

      can [ :upload, :create, :new, :driver, :set_profile_photo ], Photo
      can [ :move, :edit, :update, :destroy ], Photo do |photo|
        photo.user == user
      end
      
      can [ :new, :create, :search, :index ], Report
      can [ :edit, :update ], Report do |r|
        r.user == user
      end
      
      can [ :new, :create, :index ], Tag
      can [ :update, :edit, :destroy ], Tag do |tag|
        tag.user == user
      end

      can [ :organizer, :account, :photos, :scratchpad ], User

      can [ :manage ], Venue do |venue|
        venue.user == user
      end

      can [ :manage ], Video do |video|
        video.user == user
      end

      #
      # manager
      #
      if user[:group_id] <= 2

        can [ :manage ], City
        can [ :manage ], Gallery
        can [ :manage ], Report
        can [ :manage ], Tag
        can [ :manage ], Video

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

    can [ :show, :home, :news, :index, :about, :privacy ], Blog

    can [ :show, :home, :news, :slider, :about, :services, :team, :contact, :portfolio, :privacy ], Cac
    
    can [ :profile, :index, :show, :map, :events, :galleries, :videos, 
      :reports, :people, :users, :venues, :places, :temp ], City
    
    can [ :index, :search ], Gallery
    can [ :show ], Gallery do |g|
      g.is_public && !g.is_trash
    end

    can [ :home ], Ish

    can [ :create ], Message
    
    can [ :do_upload ], Photo
    
    can [ :index, :search ], Report
    can [ :show ], Report do |r|
      true == r.is_public && !r.is_trash
    end

    can [ :new, :create, :success ], Subscription
    
    can [ :index, :search ], Tag
    can [ :show ], Tag do |t|
      t.is_public && !t.is_trash
    end

    can [ :home, :about ], Travel
    
    can [ :resume, :reports, :galleries, :report, :gallery,
      :sign_in, :sign_up, :sign_out, :logout,
      :index, :show ], User
    can [ :report ], User do |r|
      r.is_public && !r.is_trash
    end

    can [ :index ], Video
    can [ :show ], Video do |video|
      video.is_public && !video.is_trash
    end

    can [ :set_locale, :home ], Welcome
    
    can [ :index, :search ], Venue
    can [ :show ], Venue do |v|
      v.is_public && !v.is_trash
    end
    
    can [ :index ], Video
    can [ :show ], Video do |v|
      v.is_public && !v.is_trash
    end
        
    
  end
end

