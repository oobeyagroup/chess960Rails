# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Destroying all existing Pictures, if any."
Startingpositiondiscussion.destroy_all

puts "Seed starting positions"

(1..960).each do |boardposition|

  p = Startingpositiondiscussion.new 
  p.startingpostionnumber = boardposition
  if (boardposition == 960)
    p.startingposition = "BBQNNRKR"
  elsif (boardposition == 518)
    p.startingposition = "RNBQKBNR"
  else
    p.startingposition = "*%03d*%03d" % [boardposition,boardposition]
  end
  p.comments = "Start your discussion now..."
  p.save

end