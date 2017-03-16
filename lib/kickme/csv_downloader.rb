module Kickme
  class CSVDownloader

    def self.download(options = {})
      countries = [options["countries"] || Kickme.country_names].flatten.compact.uniq
      countries.each do |country|
        web_page = Kickme.country_page(country)
        leagues = leagues_for_country(country, options["leagues"])
        leagues.each do |league|
          seasons = seasons_for_league(league, options["seasons"], web_page)
          seasons.each do |season|
            sd = SeasonDownloader.new(
              country: country,
              league: league,
              season: season,
              web_page: web_page
            )
            sd.download
          end
        end
      end
    end

    private

      def self.seasons_for_league(league, optional_seasons, web_page)
        league_csv_links = web_page.css("a:contains(\"#{league}\")")
        seasons = league_csv_links.map do |league_csv_link|
          season = league_csv_link.previous
          until season.text.include?("Season")
            season = season.previous
          end
          season.text.gsub("Season ", "")
        end
        if optional_seasons
          optional_seasons = [optional_seasons].flatten.compact.uniq
          optional_seasons.select { |season| seasons.include?(season) }
        else
          seasons
        end
      end

      def self.leagues_for_country(country, optional_leagues)
        kickme_leagues = Kickme.leagues_for(country)
        if optional_leagues
          optional_leagues = [optional_leagues].flatten.compact.uniq
          optional_leagues.select { |league| kickme_leagues.include?(league) }
        else
          kickme_leagues
        end
      end

  end

end

