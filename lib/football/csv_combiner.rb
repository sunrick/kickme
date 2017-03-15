module Football
  class CSVCombiner

    def self.combine
      config = Football.config
      country_names = config["countries"].keys
      fields = config["fields"]

      CSV.open("#{Football.root}/csv/all.csv", "w") do |csv|
        csv << fields
      end

      country_names.each do |country_name|
        country = config["countries"][country_name]
        country["leagues"].each do |league|
          cleaned_league = league.gsub(' ', '_').downcase
          files = Dir.glob("#{Football.root}/csv/#{country_name}/#{cleaned_league}/*")
          files.each do |file|
            season = File.basename(file, ".csv")
            lines = SmarterCSV.process(file, keep_original_headers: true, force_utf8: true)
            lines.each_with_index do |line, index|
              new_line = {}
              fields.each do |field|
                if field == "League"
                  new_line[field] = cleaned_league
                elsif field == "Country"
                  new_line[field] = country_name
                elsif field == "Season"
                  new_line[field] = season
                else
                  new_line[field] = line[field]
                end
              end
              lines[index] = new_line
            end

            CSV.open("#{Football.root}/csv/all.csv", "a+") do |csv|
              lines.each do |line|
                csv << line.values
              end
            end

          end
        end
      end
    end

  end
end

