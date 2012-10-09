

class UsersTasks
  
  # arg is:::: username, email, group_id
  def self.create_from_user arg
    unless self.where(:username => arg[:username]).exists?
      NoUser.create :username => arg[:username],
        :group_id => arg[:group_id],
        :email => arg[:email]
      
    end
  end
  
  
end