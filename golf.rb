

require 'csv'


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

    #puts holes.inspect
  
    #@holes = holes

    holes
 
  end

  def course_file
    File.exist?('course.csv')

  end


end



class ScoreCard < HoleLayout


  def add_score array

    @holes.each do |k,v|
      k = v.push(array[k])
    end


  end





end