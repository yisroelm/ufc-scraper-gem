class Fighter

@@all = []

  attr_accessor :link, :win_streak, :title_defenses, :ko_wins, :s_percent, :s_accuracy, :s_landed, :s_landed_num, :s_attemted, :s_attemted_num, :g_percent, :g_accuracy, :t_landed, :t_landed_num, :t_attemted, :t_attemted_num, :nickname

  attr_reader :name

  def initialize(name)
    @name = name

    @@all << self
  end

  def self.all
    @@all
  end

  def self.over_wins(num_wins)
    fighters = Fighter.all

    wins = fighters.select do |fighter|
      fighter.ko_wins.to_i > num_wins
    end
  end

end
