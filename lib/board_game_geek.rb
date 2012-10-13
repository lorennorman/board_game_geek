require "bundler/setup"
require "nokogiri"
require "open-uri"
require "ostruct"

module BoardGameGeek
  class Scraper
    RANKED_GAMES_URI = 'http://boardgamegeek.com/browse/boardgame/page/'
    GAMES_PER_PAGE   = 100

    def self.top_games how_many
      # break total into pages + remainder
      full_pages, remainder = self.break_down_total(how_many)
      # accumulate #{pages} calls to bgg
      # accumulate one more call(#{remainder}) to bgg

      Array.new.tap do |games|
        (1..(full_pages)).each do |page_number|
          how_many = GAMES_PER_PAGE
          how_many = remainder if page_number == full_pages && remainder > 0

          doc = Nokogiri::HTML(open "#{RANKED_GAMES_URI}#{page_number}.html")

          doc.css('table#collectionitems tr').each_with_index do |game_row, idx|
            next  if idx == 0
            break if idx > how_many

            cells = game_row.css("td").map(&:inner_text).map(&:strip)

            name_and_date = cells[2].to_s.split("\n")

            ranking      = cells[0]
            name         = name_and_date[0]
            release_date = name_and_date[2].to_s.strip[1..-2]
            rating       = cells[3]

            game_path = game_row.css(".collection_thumbnail a").first["href"]
            game_url = "http://boardgamegeek.com" + game_path

            image_url = game_row.css(".collection_thumbnail img").first["src"]
            image_url.sub!("_mt", "_t")

            games << OpenStruct.new(name:         name,
                                    ranking:      ranking,
                                    rating:       rating,
                                    release_date: release_date,
                                    url:          game_url,
                                    image_url:    image_url)
          end
        end
      end
    end

    def self.break_down_total total
      [(total.to_f/GAMES_PER_PAGE).ceil, total%GAMES_PER_PAGE]
    end
  end
end

BGG = BoardGameGeek
