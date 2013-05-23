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

    it "it can add scores to scorecard" do 
      expect(@sc.add_score([1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]))
      puts @sc.holes
    end





end 




