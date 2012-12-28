
class String
  
  def to_simple_string
    a = self.gsub("\.", '_')
    a = a.gsub(':', '-').gsub('%20', '-')
    a = a.downcase.strip.gsub(' ', '-')
    while a.include? '--'
      a = a.sub("--", '-')
    end
    a
  end
  
end