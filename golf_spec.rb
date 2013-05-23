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
     # g = HoleLayout.new
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


  # describe "turning hole layout into hash"


  #   it "returns a hash of holes" do

     
  #    expect(@g.read_course(@course)).to be_a Hash

  #   end


    it "has accessible instance variable of @holes" do
      @newholes = HoleLayout.new(@course)
      #expect(@newholes.holes).to_not be_nil 
      #puts @newholes.holes
      expect(@newholes.holes).to be_a Hash
    end




end

describe ScoreCard do

  describe "Check if scorecard exists"
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

    it "can access @holes" do
      puts @sc.holes
    end

    # it "it can add scores to scorecard" do 
    #   expect(@sc.add_score([1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]))
    #   puts @sc.holes
    # end

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
      puts @sc.holes.inspect
      expect(@sc.holes.values[0]).to have(3).things
    end

    it "can calculate the final score" do
      puts @sc.final_score
      expect(@sc.final_score).to be_a Fixnum
    end

    it "can calculate par for the course" do
      puts @sc.par
      expect(@sc.par).to be_a Fixnum
    end







end 




