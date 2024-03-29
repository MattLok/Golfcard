

require 'csv'
require 'pry'


class HoleLayout

#course = 'course.csv'
  attr_accessor :holes

  def initialize(course)

    @holes = read_course(course)
  end

  def read_course course

    temp = CSV.read(course)
    temp.flatten!
    #puts temp.inspect
    #holes = temp.inject(Hash.new(0)) {|key,value| key[value] += 1; value;}
    holes = Hash.new(0)    #temp.inject(Hash.new(0)) { |key, value|  key += 1; key[value] }
    (0..17).each do |x|
      count = x +1
      holes[count] = [temp[x].to_i]
    end

    holes

  end

  def course_file
    File.exist?('course.csv')

  end


end



class ScoreCard < HoleLayout

  attr_accessor :holes


  def add_score array

    @holes.each do |k,v|
      k = v.push(array[k])
    end
  end

  def score_diff

    @holes.each do |k,v|
      score = v[0] - v[1]
      #puts score
       v.push(golf_term(score))
    end


  end

  def golf_term score

    case score
      when -1
         "bogey"
      when -2
        "double bogey"
      when -3
        "triple bogey"
      when 0
        "par"
      when 1
        "birdie"
      when 2
        "eagle"
      else
        score
    end

  end

  def final_score
    #par = 0
    score = 0
    @holes.each do |k,v|
      score += v[1]
      #par += v[0]
    end

    score
  end

  def par
    par =0
    @holes.each do |k,v|
      par += v[0]
    end

    par
  end

end



class Player

  attr_reader :scorecards, :name

  def initialize(name, *course)
    @name = name
    @scorecards = []

     course.each do |file|
        @scorecards.push(ScoreCard.new(file))
      end

  end

  def first_empty_scorecard
    @scorecards.each do |card|
      if card.holes.first[1].length == 1
        return card
      end


    end

  end

  def calculate_all_diffs
    @scorecards.each do |card|
      card.score_diff
    end
  end

  def add_score_to_empty_card array

    empty = first_empty_scorecard
    empty.holes.each do |k,v|
      k = v.push(array[k])
    end
  end


  def print_player

    print "== #{@name} \n"
    @scorecards.holes.each do |k,v|
      print "Hole #{k}: #{v[0]} - #{v[2]} \n"
    end
    print "Total score: #{@scorecards.final_score} \n"
    if @scorecards.final_score > @scorecards.par
      print "+#{(@scorecards.final_score) - (@scorecards.par)}\n =="
    else
      print "#{(@scorecards.final_score) - (@scorecards.par)}\n =="
    end

  end

  def print_all_player_scores
    print "== #{@name} \n"
    @scorecards.each do |card|
      card.holes.each do |k,v|
        print "Hole #{k}: #{v[0]} - #{v[2]} \n"
      end
    print "Total score: #{card.final_score} \n"
      if card.final_score > card.par
        print "+#{(card.final_score) - (card.par)}\n =="
      else
        print "#{(card.final_score) - (card.par)}\n =="
      end
        puts
    end
    @scorecard.length
  end

  def handicap

    handi = 0
    @scorecards.each do |card|
      handi += ((card.final_score) - (card.par))
    end
    handi = (handi / @scorecards.length).round
    puts "#{@name} - #{handi} Handicap"
    handi

  end


  def write_player

    File.open("scores.csv","w") do |file|
      file.write "#{@name}, "
        @scorecard.holes.each do |k,v|
          file.write "#{v[1]},"
      end
    end
  end

end


class LeaderBoard


  def initialize (*args)

    @leaders = []
    @leaders.push(*args)

  end


  def scores

    @leaders.each do |leader|
      print "#{leader.name} - #{leader.scorecards.final_score}\n"
    end
  end

  def get_name
    @leaders[0].name
  end

  def sort
   arr = @leaders.sort{|a,b| a.scorecard.final_score <=> b.scorecard.final_score }
    arr.each do |leader|
      print "#{leader.name} - #{leader.scorecard.final_score}\n"
    end
  end

  def sort_round round
    @leaders.sort_by {|player| player.scorecards[round].final_score}

  end


  def all_rounds_sorted

    str =''

    @leaders.each_with_index do |player, index|
      sorted_players = sort_round(index)
      sorted_players.each do |x|
        str += "#{x.name} "#- #{x.scorecards[index]}\n"
      end
    end
    str
  end


  def print_each_round_leader rounds

    rounds.each_with_index do |player,index|
      round_leaders = player[index][1].sort{|a,b| a <=> b}
      puts round_leaders
    end


  end


end













