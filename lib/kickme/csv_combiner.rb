module Kickme
  class CSVCombiner

    def self.combine

      CSV.open("#{Kickme.root}/csv/all.csv", "w") do |csv|
        csv << Kickme.fields
      end

      Kickme.countries.each do |country|
        country["leagues"].each do |league|
          cleaned_league = league.gsub(' ', '_').downcase
          files = Dir.glob("#{Kickme.root}/csv/#{country["name"]}/#{cleaned_league}/*")
          files.each do |file|
            season = File.basename(file, ".csv")
            lines = SmarterCSV.process(file, keep_original_headers: true, force_utf8: true)
            lines.each_with_index do |line, index|
              new_line = {}
              Kickme.fields.each do |field|
                if field == "League"
                  new_line[field] = cleaned_league
                elsif field == "Country"
                  new_line[field] = country["name"]
                elsif field == "Season"
                  new_line[field] = season.gsub("season_", "")
                else
                  new_line[field] = line[field]
                end
              end
              lines[index] = new_line
            end

            CSV.open("#{Kickme.root}/csv/all.csv", "a+") do |csv|
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

