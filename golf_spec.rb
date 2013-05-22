require 'rspec'
require_relative 'golf'


describe HoleLayout  do

  describe "Score Card"

  before(:each) do
    @g = HoleLayout.new
  end

    it "exists" do
     # g = HoleLayout.new
      expect(@g).not_to be_nil

    end


    it "checks if there is a csv file" do

      expect(@g.read_course).to_not be_nil
    end

    it "checks if course file exists" do

      expect(@g.course_file).to be_true

    end



end



