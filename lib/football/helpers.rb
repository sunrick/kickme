module Football

  def self.root
    File.expand_path('../../..', __FILE__)
  end

  def self.config
    file = File.read("#{self.root}/config.json")
    JSON.parse(file)
  end

end
