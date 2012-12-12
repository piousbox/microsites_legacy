

class Ability

  include CanCan::Ability

  def initialize(user)
    
    #
    # signed in user
    #
    unless user.blank?

      can [ :set_city ], City

      can [ :new, :create, :search, :index ], Day
      can :manage, Day do |day|
        day.user == user
      end

      can [ :create, :new ], Gallery
      can [ :edit, :update ], Gallery do |g|
        g.user == user
      end

      can [ :upload, :create, :new, :driver ], Photo
      
      can [ :new, :create, :search, :index ], Report
      can [ :edit, :update ], Report do |r|
        r.user == user
      end
      
      can [ :new, :create ], Tag

      can [ :organizer, :account, :photos ], User

      #      can [ :create, :index, :new ], Addressbookitem
      #      can :manage, Addressbookitem do |a|
      #        a.user_id == user.id
      #      end
      #
      #      can [ :create, :new ], CitiesUser
      #      can :manage, CitiesUser do |cu|
      #        cu.user_id == user.id
      #      end
      #      
      #      can [ :set_profile_photo, :move, :driver, :create_for_gallery, :create ], Photo
      #      can [ :edit, :update ], Photo do |ph|
      #        ph[:user_id] == user[:id]
      #      end
      #      

      #
      # manager
      #
      if user[:group_id] <= 2

        can [ :manage ], Report

        can [ :manager ], Tag

        #      can [ :mark_features ], Gallery
        #
        #      can [ :mark_features, :manager_dashboard ], Report
        #
        #      can [ :mark_features ], Video
        #
        #      can [ :manage ], City

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
    
    can [ :profile, :index, :show, :map, :events, :galleries, :videos, :reports, :people, :users, :venues, :places ], City
    
    can [ :index ], Gallery
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
    
    can [ :index ], Tag
    can [ :show ], Tag do |t|
      t.is_public && !t.is_trash
    end

    can [ :home, :about ], Travel
    
    can [ :resume, :reports, :galleries, :reports, :sign_in, :index, :galleries,
      :gallery, :reports ], User
    can [ :report ], User do |r|
      r.is_public && !r.is_trash
    end

    can [ :index ], Video
    can [ :show ], Video do |video|
      video.is_public && !video.is_trash
    end

    can [ :set_locale, :home ], Welcome
    
    #    
    #    can [ :index, :index_small, :new, :create, :show, :events, :users, :join ], Community
    #    can :manage, Community do |community|
    #      community.user_id == user.id
    #    end
    #
    #    can [ :free_photo_hosting, :index_small, :search, :index_2 ], Gallery 
    #    can [ :show ], Gallery do |g|
    #      g[:is_public] == 1 && g[:is_trash] == 0
    #    end
    #
    #    can [:index, :index_small, :new, :create, :show], Event
    #    can [ :show], Event do |ee|
    #      ee.is_public && !ee[:is_trash]
    #    end
    #    can :manage, Event do |e|
    #      e.user_id.to_s == user.id.to_s
    #    end
    #    
    #    can [ :index, :homepage, :global_feature, :index_small, :popup,
    #      :search_google, :search, :html_data, :search, :old_content ], Report
    #    can [ :show, :promo ], Report do |r|
    #      r[:is_public] == 1 && r[:is_trash] == 0
    #    end
    #    can :manage, Report do |r|
    #      r[:user_id] == user[:id]
    #    end
    #
    #    can [ :index, :index_small, :reports, :homepage ], Tag
    #    can [ :show], Tag do |t|
    #      t.is_public == 1 && t[:is_trash] == 0
    #    end
    #    can :manage, Tag do |tag|
    #      tag.user_id == user.id
    #    end
    #    
    #    can [ :show, :index, :index_small, :new, :html_data, 
    #      :reports_data, :galleries_data, :post_layout, :set_username,
    #      :sign_in, :sign_out, :facebook, :failure ], User
    #
    #    can [ :index, :index_small ], Venue
    #    can :manage, Venue do
    #      user[:group_id] == 2
    #    end
    #    can [ :show ], Venue do |v|
    #      v[:is_public] && !v[:is_trash]
    #    end
    #    can :manage, Venue do |v|
    #      v.user_id == user.id
    #    end
    #
    #    can [ :index ], Video
    #    can [ :show ], Video do |v|
    #      v[:is_public] && !v[:is_trash]
    #    end
    #    can :manage, Video do |v|
    #      v[:user_id] == user[:id]
    #    end
    
  end
end

