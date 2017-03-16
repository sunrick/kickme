module Kickme
  class SeasonDownloader

    attr_reader :country, :league, :web_page

    def initialize(country:, league:, season:, web_page: nil)
      @country = country
      @league = league
      @season = season
      @web_page = web_page || Kickme.country_page(@country)
    end

    def season
      if @season.include?("Season")
        @season
      else
        "Season #{@season}"
      end
    end

    def download
      find_csv_link
      create_file
      puts "Created CSV for: #{@country}, #{@league}, #{@season}"
    end

    private

      def find_csv_link
        season_element = web_page.at_css("i:contains(\"#{season}\")")
        @csv_link = season_element.next_element
        until @csv_link.text.include?(league)
          @csv_link = @csv_link.next_element
        end
        @csv_link
      end

      def create_file
        clean_country = country.downcase
        clean_league = league.gsub(' ', '_').downcase
        clean_season = season.gsub(' ', '_').gsub('/', '-').downcase
        directory_path = "./csv/#{country}/#{clean_league}"
        FileUtils::mkdir_p(directory_path) if !File.exists?(directory_path)
        file = open("#{Kickme.base_uri}/#{@csv_link.attributes["href"].value}")
        IO.copy_stream(file, "#{directory_path}/#{clean_season}.csv")
      end

  end
end
