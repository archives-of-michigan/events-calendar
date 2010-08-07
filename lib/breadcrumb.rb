class Breadcrumb
  attr_accessor :text, :url

  def initialize(args)
    args.each do |name, value|
      self.send("#{name}=",value)
    end
  end
end
