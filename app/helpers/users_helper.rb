

module UsersHelper
  
  
  def user_path u
    "users/#{u.username}/resume"
  end
end