class CLI

  def run
    welcome
    get_fighters
    main_page
  end

  def welcome
    puts "It's Tiiiiiiiiimmmmmmmmmmeeeeeee!!!!!!!!!!!!"
    puts "***********************************************************************************************"
    puts "\n"
  end

  def get_fighters
    Scraper.get_fighters
  end

  def all_fighters
    Fighter.all.each_with_index do |fighter, index|
      puts "#{index+1})| #{fighter.name}"
      puts"******************************"

    end
  end

  def main_page
    puts "Enter a fighters number to see their stats:"
    puts "#############################"
    all_fighters

    input = gets.chomp
    if input == "0"
      fighter = nil
    else
      fighter = Fighter.all[input.to_i-1]
    end
    if fighter == nil
      # puts "#############################"
      puts "Enter an existing fighter number!"
      puts "#############################"

      main_page
    else
      Scraper.get_fighter_stats(fighter)
    end
    show_stats(fighter)
  end

  def show_stats(fighter)
    # binding.pry
    puts "#############################"
    if fighter.nickname == ""
    puts "You Have Selected #{fighter.name}!!"
    puts "Your Fighter Has No Nickname"
    else
    puts "You Have Selected #{fighter.name}!!"
    puts "Your Fighters Nickname Is: " +  fighter.nickname.upcase + "!!!!!!!!!!"
    end
    puts "Fight Stats:"
    puts fighter.win_streak
    puts fighter.title_defenses
    puts fighter.ko_wins
    puts fighter.s_accuracy.upcase + ":"
    puts fighter.s_percent
    puts fighter.s_landed.upcase + ":"
    puts fighter.s_landed_num
    puts fighter.s_attemted.upcase + ":"
    puts fighter.s_attemted_num
    puts fighter.g_accuracy.upcase + ":"
    puts fighter.g_percent
    puts fighter.t_landed.upcase + ":"
    puts fighter.t_landed_num
    puts fighter.t_attemted.upcase + ":"
    puts fighter.t_attemted_num

    anything_else?
  end

  def anything_else?
    puts "*********************************"
    puts "Select a diffrent Fighter?"
    puts "[Y/N]"

    input = gets.chomp.upcase
    if input == 'Y'
      main_page
    elsif input == 'N'
      puts "Goodbye!"
    else
      puts "*********************************"
      puts "Please Enter [Y/N]"
      anything_else?
    end
  end



end
