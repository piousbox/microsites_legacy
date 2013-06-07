
class TitleizeReports

  @queue = :standard_queue

  def self.perform args = {}
    reports = Report.all.where( :is_trash => false, :is_public => true )
    reports.each do |r|
      if r.name != r.name.titleize
        r.name = r.name.titleize
        puts "Titleized #{r.name}"
        flag = r.save
      end
    end
  end

  def puts! args
    puts '+++ +++'
    puts args.inspect
  end

end
