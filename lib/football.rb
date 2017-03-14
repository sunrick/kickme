require 'open-uri'
require 'nokogiri'
require 'pry'
require 'json'
require 'fileutils'

require "football/version"
require "football/csv_downloader"

module Football

  def self.root
    File.expand_path('../..', __FILE__)
  end

  def self.config
    file = File.read("#{root}/config.json")
    JSON.parse(file)
  end

end
