require 'rspec'
require_relative 'golf'


describe HoleLayout  do

  describe "Checking if file exists and reading it"

    before(:each) do
      @g = HoleLayout.new
      @course = 'course.csv'
    end

 
    it "exists" do
     # g = HoleLayout.new
      expect(@g).not_to be_nil

    end

    it "checks if course file exists" do

      expect(@g.course_file).to be_true

    end

     it "reads the csv file" do

      expect(@g.read_course(@course)).to be_a Array
    end

    it "has 18 holes" do

      expect(@g.read_course(@course)).to have(18).things
    end




end



