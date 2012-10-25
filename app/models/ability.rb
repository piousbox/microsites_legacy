

class Ability

  include CanCan::Ability

  def initialize(user)
    
    #
    # signed in user
    #
    unless user.blank?
      
      can [ :new, :create, :search ], Day
      can :manage, Day do |day|
        day.user == user
      end
      
      can [ :organizer, :account, :photos ], User
      
      can [ :upload, :do_upload, :create, :new ], Photo
      
      can [ :new, :create ], Report
      
      can [ :new, :create ], Tag
      
      #      can [ :create, :index, :new ], Addressbookitem
      #      can :manage, Addressbookitem do |a|
      #        a.user_id == user.id
      #      end
      #      
      #      can [ :set_city ], City
      #      
      #      can [ :create, :new ], CitiesUser
      #      can :manage, CitiesUser do |cu|
      #        cu.user_id == user.id
      #      end
      
      
      
      #      can [ :new, :create ], Dictionaryitem
      #      
      #      can [ :index, :index_small, :new, :create ], Gallery
      #      can [ :manage ], Gallery do |g|
      #        g.user_id == user.id
      #      end
      
      
      #      can [ :set_profile_photo, :move, :driver, :create_for_gallery, :create ], Photo
      #      can [ :edit, :update ], Photo do |ph|
      #        ph[:user_id] == user[:id]
      #      end
      #      
      #      can [ :dashboard ], User
      #      
      #      can :manage, VenueType do 
      #        user.group_id == 2
      #      end
      #      
      #      can [ :new, :create, :show ], Page
      #      can :manage, Page do |page|
      #        page[:user_id] == user[:id]
      #      end
      #      
      #      
      #      
      #      
      #      
      #      
      #
      # if admin
      #
      can :manage, :all do
        user.group_id == 1 
      end
    
      
    end
    
    user ||= User.new
    
    #
    # manager
    #
    if user[:group_id] == 2
      
      #      can [ :mark_features ], Gallery
      #      
      #      can [ :mark_features, :manager_dashboard ], Report
      #      
      #      can [ :mark_features ], Video
      #      
      #      can [ :manage ], City
      
    end
    
    
    
    
    
    
    
    
    ###
    ### applies to all users
    ###
    
    
    
    
    can [ :index ], Gallery
    can [ :show ], Gallery do |g|
      g.is_public
    end
    
    
    can [ :index ], Photo
    
    can [ :index, :search ], Report
    can [ :show ], Report do |r|
      true == r.is_public
    end
    
    can [ :resume, :galleries, :reports, :sign_in, :index, :galleries, :reports ], User
    
    #    
    #    can [ :index, :index_small, :new, :create, :show, :events, :users, :join ], Community
    #    can :manage, Community do |community|
    #      community.user_id == user.id
    #    end
    #
    #
    #
    #    can [ :index, :free_photo_hosting, :index_small, :search, :index_2 ], Gallery 
    #    can [ :show ], Gallery do |g|
    #      g[:is_public] == 1 && g[:is_trash] == 0
    #    end
    #
    #    
    #    
    #    
    #    can [:index, :index_small, :new, :create, :show], Event
    #    can [ :show], Event do |ee|
    #      ee.is_public && !ee[:is_trash]
    #    end
    #    can :manage, Event do |e|
    #      e.user_id.to_s == user.id.to_s
    #    end
    #    
    #    
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
    #
    #    
    #
    #    
    #    can [:index, :show, :foldin, :map, :map_all, :events], City
    #
    #
    #
    #    can [ :index, :index_small, :reports, :homepage ], Tag
    #    can [ :show], Tag do |t|
    #      t.is_public == 1 && t[:is_trash] == 0
    #    end
    #    can :manage, Tag do |tag|
    #      tag.user_id == user.id
    #    end
    #
    #		
    #    
    #    
    #    can [ :show, :index, :index_small, :new, :html_data, 
    #      :reports_data, :galleries_data, :post_layout, :set_username,
    #      :sign_in, :sign_out, :facebook, :failure ], User
    #
    #
    #
    #    # venue
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
    #    
    #    
    #    # video
    #    can [ :index ], Video
    #    can [ :show ], Video do |v|
    #      v[:is_public] && !v[:is_trash]
    #    end
    #    can :manage, Video do |v|
    #      v[:user_id] == user[:id]
    #    end
    
  end
end

