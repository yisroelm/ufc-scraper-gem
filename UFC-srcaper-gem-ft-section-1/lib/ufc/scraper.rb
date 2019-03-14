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
    url = fighter.link
    doc = Nokogiri::HTML(open(url))
    ################################################################################################
    fighter.nickname = doc.css(".field.field-name-nickname").text.gsub("\n","").strip.gsub("\"", "")
                                    #STATS AND WIN STREAK
    fighter.win_streak = doc.css(".l-listing__group")[0].css(".l-listing__item")[0].text.gsub("\n","").strip

    fighter.title_defenses = doc.css(".l-listing__group")[0].css(".l-listing__item")[2].text.gsub("\n","").strip

    fighter.ko_wins = doc.css(".l-listing__group")[0].css(".l-listing__item")[1].text.gsub("\n","").strip

    ##################################################################################################
                                      #STRIKING ACCURACY
    fighter.s_percent =  doc.css(".e-chart-circle__percent")[0].text

    fighter.s_accuracy = doc.css(".c-overlap--stats__title")[0].text.gsub("\n","").strip

    fighter.s_landed = doc.css(".c-overlap__stats-text")[0].text.gsub("\n","").strip
    fighter.s_landed_num = doc.css(".c-overlap__stats-value")[0].text

    fighter.s_attemted = doc.css(".c-overlap__stats-text")[1].text.gsub("\n","").strip
    fighter.s_attemted_num = doc.css(".c-overlap__stats-value")[1].text
    #########################################################################################
                                    #GRAPPLING ACCURACY
    fighter.g_percent = doc.css(".e-chart-circle__percent")[1].text

    fighter.g_accuracy = doc.css(".c-overlap--stats__title")[1].text.gsub("\n","").strip


    fighter.t_landed = doc.css(".c-overlap__stats-text")[2].text.gsub("\n","").strip
    fighter.t_landed_num = doc.css(".c-overlap__stats-value")[2].text

    fighter.t_attemted = doc.css(".c-overlap__stats-text")[3].text.gsub("\n","").strip
    fighter.t_attemted_num = doc.css(".c-overlap__stats-value")[3].text
    ###########################################################################################
  end
end
