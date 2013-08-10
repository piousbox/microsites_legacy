
class LineFilter < SimpleCov::Filter
  def matches?(source_file)
    source_file.lines.count < filter_argument
  end
end

SimpleCov.start do

  add_filter '/vendor'
  add_filter '/spec'
  add_filter '/config'

  add_group 'Models', 'app/models'
  add_group 'Controllers', 'app/controllers'

  add_group "Long files" do |src_file|
    src_file.lines.count > 100
  end
  add_group "Short files", LineFilter.new(5) # Using the LineFilter class defined in Filters section above

end
