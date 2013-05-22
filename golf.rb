

require 'csv'


class HoleLayout

#course = 'course.csv'

  def read_course course

    holes = CSV.read(course)
    
      
    puts holes
    puts holes.class
  end

  def course_file
    File.exist?('course.csv')

  end


end