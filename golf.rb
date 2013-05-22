

require 'csv'


class HoleLayout

#course = 'course.csv'

  def read_course course

    temp = CSV.read(course)
    temp.flatten!
    #puts temp.inspect
    #holes = temp.inject(Hash.new(0)) {|key,value| key[value] += 1; value;}
    holes = Hash.new(0)    #temp.inject(Hash.new(0)) { |key, value|  key += 1; key[value] }
    (0..17).each do |x|
      count = x +1
      holes[count] = [temp[x]]
    end

    #puts holes.inspect
  
    holes
 
  end

  def course_file
    File.exist?('course.csv')

  end


end



class ScoreCard





end