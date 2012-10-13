

module UsersHelper
  
  
  def user_resume_path u
    return "/users/#{u.username}/resume"
  end
  
  def user_reports_path u
    return "/users/#{u.username}/articles"
  end
  
  def user_galleries_path u
    return "/users/#{u.username}/galleries"
  end
  
  def user_github_path u
    u.github_path
  end
end