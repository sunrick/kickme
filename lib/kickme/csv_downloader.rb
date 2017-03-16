module Kickme
  class CSVDownloader

    def self.download(options = {})
      base_uri = "http://www.football-data.co.uk"
      config = Kickme.config
      country_names = options["countries"].nil? ? config["countries"].keys : options["countries"]
      country_names.each do |country_name|
        country = config["countries"][country_name]
        website = open("#{base_uri}/#{country["web_entry"]}")
        doc = Nokogiri::HTML(website)
        country["leagues"].each do |league|
          cleaned_league = league.gsub(' ', '_').downcase
          premier_league_links = doc.css("a:contains(\"#{league}\")")
          premier_league_links.each do |link|
            previous_element = link.previous
            until previous_element.text.include?("Season")
              previous_element = previous_element.previous
            end
            season = previous_element.text.gsub(' ', '_').gsub('/', '-').downcase
            directory_path = "./csv/#{country_name}/#{cleaned_league}"
            FileUtils::mkdir_p(directory_path) if !File.exists?(directory_path)
            file = open("#{base_uri}/#{link.attributes["href"].value}")
            IO.copy_stream(file, "#{directory_path}/#{season}.csv")
          end
        end
      end
    end

  end
end
