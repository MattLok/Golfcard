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
      expect(@sc.holes.values[0]).to have(3).things
    end

    it "can calculate the final score" do

      expect(@sc.final_score).to be_a Fixnum
    end

    it "can calculate par for the course" do
      expect(@sc.par).to eql(72)
    end


end

describe Player do



  before(:each) do
      @course = 'course.csv'
      @course2 = 'course2.csv'
      @p1 = Player.new("Matt M", @course, @course2)
      @p1.add_score_to_empty_card([4,4,3,5,6,6,2,3,3,4,4,7,8,9,2,4,3,5,2])
      @p1.add_score_to_empty_card([4,4,3,5,6,6,2,5,5,4,5,7,8,9,2,4,3,5,3])
      @p1.calculate_all_diffs


  end

    it "exists" do
      expect(@p1).to_not  be_nil
    end

    it "has a scorecard" do
      expect(@p1.scorecards[0]).to_not be_nil
    end

    it "has multiple scorecards" do
       expect(@p1.scorecards[1]).to_not be_nil
    end

    it "can calculate a players handicap" do
      expect(@p1.handicap).to be_a Fixnum

    end


end


describe LeaderBoard do



  describe "board"

  before(:each) do
    @course = 'course.csv'
    @course2 = 'course2.csv'
    @p1 = Player.new("Matt M", @course,@course2)
    @p1.add_score_to_empty_card([4,4,3,5,6,6,2,6,3,4,4,7,8,9,2,4,3,5,2]) #87
    @p1.add_score_to_empty_card([3,3,5,5,6,6,3,6,3,4,4,7,8,9,2,4,3,5,2]) #88

    @p1.calculate_all_diffs

    @p2 = Player.new("Carl Z", @course,@course2)
    @p2.add_score_to_empty_card([4,4,3,5,6,6,2,3,3,4,4,7,8,9,2,4,3,5,4])#86
    @p2.add_score_to_empty_card([4,4,3,5,5,5,2,6,3,4,4,7,8,9,2,4,3,5,2]) #85

    @p2.calculate_all_diffs

    @p3 = Player.new("Fuzzy Z", @course, @course2)
    @p3.add_score_to_empty_card([4,5,4,5,6,6,4,3,3,5,5,7,8,9,2,4,3,5,2]) #90
    @p3.add_score_to_empty_card([3,2,3,5,6,6,2,6,3,4,4,7,5,5,2,4,1,5,2]) #75

    @p3.calculate_all_diffs

    @leaders = LeaderBoard.new(@p1,@p2,@p3)
  end

  it "exists" do

    expect(@leaders).to_not be_nil

  end


  it "checks if player name is accessible" do
    expect(@leaders.get_name).to be_a String
  end


  it "can sort by an individual round" do
    expect(@leaders.sort_round(1)[0]).to eql(@p3)
  end

end


