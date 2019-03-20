class Scraper

  URL = "https://www.ufc.com/rankings?rankings_panelist=1082"

  def self.get_fighters
    doc = Nokogiri::HTML(open(URL))
    fighters = doc.css(".view-grouping-content")[0].css(".views-row")

    fighters.each do |fighter|
      name = fighter.text
      link = fighter.css("a").first.attributes["href"].value
      new_fighter = Fighter.new(name)
      new_fighter.link = "https://www.ufc.com" + link
    end
  end

  def self.get_fighter_stats(fighter)
    binding.pry
    url = fighter.link
    docu = Nokogiri::HTML(open(url))
    ################################################################################################
    fighter.nickname = docu.css(".field.field-name-nickname").text.gsub("\n","").strip.gsub("\"", "")
                                    #STATS AND WIN STREAK
                                    # binding.pry
    fighter.win_streak = docu.css(".l-listing__group")[0].css(".l-listing__item")[0].text.gsub("\n","").squeeze(" ").strip

    fighter.title_defenses = docu.css(".l-listing__group")[0].css(".l-listing__item")[2].text.gsub("\n","").squeeze(" ").strip

    fighter.ko_wins = docu.css(".l-listing__group")[0].css(".l-listing__item")[1].text.gsub("\n","").squeeze(" ").strip
    binding.pry

    ##################################################################################################
                                      #STRIKING ACCURACY
    fighter.s_percent =  docu.css(".e-chart-circle__percent")[0].text

    fighter.s_accuracy = docu.css(".c-overlap--stats__title")[0].text.gsub("\n","").strip

    fighter.s_landed = docu.css(".c-overlap__stats-text")[0].text.gsub("\n","").strip
    fighter.s_landed_num = docu.css(".c-overlap__stats-value")[0].text

    fighter.s_attemted = docu.css(".c-overlap__stats-text")[1].text.gsub("\n","").strip
    fighter.s_attemted_num = docu.css(".c-overlap__stats-value")[1].text
    #########################################################################################
                                    #GRAPPLING ACCURACY
    fighter.g_percent = docu.css(".e-chart-circle__percent")[1].text

    fighter.g_accuracy = docu.css(".c-overlap--stats__title")[1].text.gsub("\n","").strip


    fighter.t_landed = docu.css(".c-overlap__stats-text")[2].text.gsub("\n","").strip
    fighter.t_landed_num = docu.css(".c-overlap__stats-value")[2].text

    fighter.t_attemted = docu.css(".c-overlap__stats-text")[3].text.gsub("\n","").strip
    fighter.t_attemted_num = docu.css(".c-overlap__stats-value")[3].text
    ###########################################################################################

    # nick = docu.css(".field.field-name-nickname").text.gsub("\n","").strip.gsub("\"", "")
    # docu.css(".field.field-name-nickname").text
    # binding.pry
    # nick.select { |string| string.include?("#{fighter.nickname}")}
    #   if(nick.first != nil)
    #     fighter.nickname = nick.first.strip
    #   end

  end
end
