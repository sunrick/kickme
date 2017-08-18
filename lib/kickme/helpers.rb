module Kickme

  def self.root
    File.expand_path('../../..', __FILE__)
  end

  def self.config
    file = File.read("#{self.root}/config.json")
    JSON.parse(file)
  end

  def self.country_names
    config["countries"].map { |country| country["name"] }
  end

  def self.countries
    config["countries"]
  end

  def self.leagues_for(country_name)
    country_name = country_name.capitalize # frozen string error from thor
    countries.detect { |country| country["name"] == country_name }["leagues"]
  end

  def self.base_uri
    "http://www.football-data.co.uk"
  end

  def self.fields
    config["fields"]
  end

  def self.country_page(country_name)
    country_name = country_name.capitalize # frozen string error from thor
    country_url = countries.detect { |country| country["name"] == country_name }["web_entry"]
    Nokogiri::HTML(open("#{Kickme.base_uri}/#{country_url}"))
  end

end
