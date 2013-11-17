
class String
  
  def to_simple_string
    a = self.downcase.strip.gsub('%20', '-').gsub(' ', '-').gsub(/[^0-9a-z]/i, '-')
    while a.include? '--'
      a = a.sub("--", '-')
    end
    a = a.gsub(/-$/, '')
    return a
  end
  
end
