require 'rspec'
require_relative 'golf'


describe HoleLayout  do

   before(:each) do
      #@g = HoleLayout.new
      @course = 'course.csv'
      @g = HoleLayout.new(@course)
    end


  describe "Checking if file exists and reading it"

   
 
    it "exists" do
 
      expect(@g).not_to be_nil

    end

    it "checks if course file exists" do

      expect(@g.course_file).to be_true

    end

     it "reads the csv file" do

      expect(@g.read_course(@course)).not_to be_nil
    end

    it "has 18 holes" do

      expect(@g.read_course(@course)).to have(18).things
    end


    it "has accessible instance variable of @holes" do
      @newholes = HoleLayout.new(@course)
      #expect(@newholes.holes).to_not be_nil 
      #puts @newholes.holes
      expect(@newholes.holes).to be_a Hash
    end




end

describe ScoreCard do

  describe "it has accessible holes"
    before(:each) do
      @course = 'course.csv'
      @sc = ScoreCard.new(@course)
      @sc.add_score([4,4,3,5,6,6,2,3,3,4,4,7,8,9,2,4,3,5,2])

    end

    it "exists" do
      expect(@sc).not_to be_nil
    end

    it "inherits from HoleLayout" do
      expect(@sc).to be_a_kind_of HoleLayout
    end


  describe "Altering and accessing the scorecard"

    it "can check difference between actual score and par" do 
      #puts @sc.holes.inspect  
      expect(@sc.score_diff).to_not be_nil

    end

    it "can convert score difference into golf terminology" do 
      expect(@sc.golf_term(1)).to eql("birdie")
      expect(@sc.golf_term(2)).to eql("eagle")
      expect(@sc.golf_term(0)).to eql("par")
      expect(@sc.golf_term(-1)).to eql("bogey")
      expect(@sc.golf_term(5)).to be_a Fixnum

    end

    it "writes the score term to the scorecard" do
      @sc.score_diff
      #puts @sc.holes.inspect
      expect(@sc.holes.values[0]).to have(3).things
    end

    it "can calculate the final score" do
      #puts @sc.final_score
      expect(@sc.final_score).to be_a Fixnum
    end

    it "can calculate par for the course" do
      #puts @sc.par
      expect(@sc.par).to eql(72)
    end


end 

describe Player do 


 
  before(:each) do
      @course = 'course2.csv'
      #@course2 = 'course2.csv'
      #@sc = ScoreCard.new(@course)
      #@sc.add_score([4,4,3,5,6,6,2,3,3,4,4,7,8,9,2,4,3,5,2])
      @p1 = Player.new("Matt M", @course) #, @course2)
      @p1.add_score_to_empty_card([4,4,3,5,6,6,2,3,3,4,4,7,8,9,2,4,3,5,2])
      @p1.calculate_all_diffs


  end

    it "exists" do
      expect(@p1).to_not  be_nil

    end

    it "has a scorecard" do
      puts @p1.scorecard.holes
      puts @p1.scorecard.inspect
      expect(@p1.scorecard).to_not be_nil
    end

    it "has multiple scorecards" do
      expect(@p1.scorecard[1]).to_not be_nil
    end



    it "prints a player scorecard" do
      @p1.print_player
      #expect(@p1.print_player).to_not be_nil
    end

    it "checks if scorecard file exists" do
      File.exist?("/Users/Matt/documents/challenges/golf/score.csv")

    end

    it "writes to scorecard file" do
      @p1.write_player

    end


end


describe LeaderBoard do



  describe "board"

  before(:each) do
    @course = 'course.csv'
    @p1 = Player.new("Matt M", @course)
    @p1.scorecard.add_score([4,4,3,5,6,6,2,6,3,4,4,7,8,9,2,4,3,5,2])
    @p1.scorecard.score_diff

    @p2 = Player.new("Carl Z", @course)
    @p2.scorecard.add_score([4,4,3,5,6,6,2,3,3,4,4,7,8,9,2,4,3,5,4])
    @p2.scorecard.score_diff

    @p3 = Player.new("Fuzzy Z", @course)
    @p3.scorecard.add_score([4,5,4,5,6,6,4,3,3,5,5,7,8,9,2,4,3,5,2])
    @p3.scorecard.score_diff

    @leaders = LeaderBoard.new(@p1,@p2,@p3)
  end
    it "exists" do

      expect(@leaders).to_not be_nil


    end

    it "expect to have 3 elements" do
      #puts @leaders.inspect
      #expect(@leaders.length).to eql(3)
    end

   

    it "checks if player name is accessible" do
      expect(@leaders.get_name).to be_a String
    end

    it "lists player scores" do

      #@leaders.scores
      expect(@leaders.scores).to be_a Array


    end

    it "sorts the leader board" do
      #@leaders.sort
      #expect(@leaders.test).to be_a Fixnum
      expect(@leaders.sort).to eql [@p2,@p1,@p3]
    end


end


