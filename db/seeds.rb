# class Board
  # a POSITION is an integer 1..906
  # a ROW is a string like "RNBQKBNR"
  
  # startingRowForPostion:(startingPosition)
  # Convert a starting position number into a row configuration
  # a) Divide the number by 960, determine the remainder (0 ... 959) and use that number thereafter. Position number 960 is identical to position number 0.
  #      b) Divide the number by 4, determine the remainder (0 ... 3) and correspondingly place a Bishop upon the matching bright square (b, d, f, h).
  # c) Divide the number by 4, determine the remainder (0 ... 3) and  correspondingly place a Bishop upon the matching dark square (a, c, e, g).
  #      d) Divide the number by 6, determine the remainder (0 ... 5) and correspondingly place the Queen upon the matching of the six free squares.
  #      e) Now only one digit (0 ... 9) is left on hand; place the both Knights upon the remaining five free squares according to following scheme
  # 
  # Digit  Knight positioning
  # 
  #           0  N   N   -   -   -
  #           1  N   -   N   -   -
  #           2  N   -   -   N   -
  #           3  N   -   -   -   N
  #           4  -   N   N   -   -
  #           5  -   N   -   N   -
  #           6  -   N   -   -   N
  #           7  -   -   N   N   -
  #           8  -   -   N   -   N
  #           9  -   -   -   N   N
  # 
  # f) The now still remaining three free squares will be filled in the following sequence: Rook, King, Rook.


  def startingRowForPostion(sp)
    starting_row = "********"
    free_cols = [0,1,2,3,4,5,6,7]
#    puts "\nstarting_row: %s  sp=%d" % [starting_row, sp]
#    puts "free_cols:", free_cols

    # place the bishops
    bright_bishop_column = (sp % 4)*2 +1
    starting_row[bright_bishop_column] = 'B'
    sp /= 4
#    puts "starting_row: %s  sp=%d" % [starting_row, sp]
    # puts "free_cols:", free_cols

    dark_bishop_column = (sp % 4)*2
    starting_row[dark_bishop_column] = 'B'

    if (bright_bishop_column > dark_bishop_column)
      free_cols.delete_at(bright_bishop_column)
      free_cols.delete_at(dark_bishop_column)
    else
      free_cols.delete_at(dark_bishop_column)
      free_cols.delete_at(bright_bishop_column)
    end
    sp /= 4
#    puts "starting_row: %s  sp=%d" % [starting_row, sp]
#    puts "free_cols:", free_cols

    # place the queen
    queen = sp % 6
    starting_row[free_cols[queen]] = 'Q'
    free_cols.delete_at(queen)
    sp /= 6
    sp %= 10
#    puts "starting_row: %s  sp=%g" % [starting_row, sp]
#    puts "free_cols:", free_cols

    # place the knights accorind to the table
    knight_position_array = [
                             [0,1],
                             [0,2],
                             [0,3],
                             [0,4],
                             [1,2],
                             [1,3],
                             [1,4],
                             [2,3],
                             [2,4],
                             [3,4]]
    k0 = knight_position_array[sp][0]
    k1 = knight_position_array[sp][1]
    starting_row[free_cols[k0]] = 'N'
    starting_row[free_cols[k1]] = 'N'
#    puts "starting_row: %s  sp=%d" % [starting_row, sp]
#    puts "free_cols:", free_cols

    # place the final R,K,R in the remaining empty columns
    starting_row[starting_row.index('*')] = 'R'
#    puts "starting_row: %s" % starting_row
    starting_row[starting_row.index('*')] = 'K'
#    puts "starting_row: %s" % starting_row
    starting_row[starting_row.index('*')] = 'R'
#    puts "starting_row: %s" % starting_row
    
    return starting_row
  end

  # def startingPostionForRow(row)
  # 
  #   # find the Bishop columns
  #   bishop_left = row.index('B')
  #   bishop_right = row.index('B', bishop_left+1)
  # 
  #   # convert to values for the starting_position formula
  #   if ((bishop_left % 2) == 0)
  #     # dark-square bishop
  #     dark_bishop = bishop_left/2
  #     bright_bishop = (bishop_right-1)/2
  #   else
  #     bright_bishop = (bishop_left-1)/2
  #     dark_bishop = bishop_right/2
  #   end
  # 
  #   # remove the bishops from the row string
  #   no_bishops = row.gsub(/B/, '')
  #   # record the position of the Queen
  #   q = no_bishops.index('Q')
  #   
  #   # remove the Queen from the row string
  #   no_BQ = no_bishops.gsub(/Q/, '')
  #   
  #   # record knight positions
  #   n1 = no_BQ.index('N')
  #   n2 = no_BQ.index('N', n1+1)
  #   knight_position_array = [
  #                            [0,1],
  #                            [0,2],
  #                            [0,3],
  #                            [0,4],
  #                            [1,2],
  #                            [1,3],
  #                            [1,4],
  #                            [2,3],
  #                            [2,4],
  #                            [3,4]]
  #   # use n1,n2 to look up king value for starting_position formula
  #   k = knight_position_array.index([n1,n2])   
  # 
  #   # use values to compute starting_position according to formula
  #   starting_position = 4*(4*(6*k + q) + dark_bishop) + bright_bishop
  # 
  #   # this is for 1-based not 0-based starting positions
  #   # i.e. 1..960 starting positions (vs. 0..959)
  #   if starting_position == 0
  #     starting_position = 960
  #   end
  # 
  #   return starting_position
  # end

# end


puts "Destroying all existing board positions, if any."
Startingpositiondiscussion.destroy_all

puts "Seed starting positions"

(1..960).each do |boardposition|


  p = Startingpositiondiscussion.new 
  p.startingpostionnumber = boardposition
  p.startingposition = startingRowForPostion(boardposition)
  p.comments = "Start your discussion now..."
  p.save

#  puts "Position:" + boardposition.to_s + "    " +  p.startingposition

end
puts "Seed complete, " + Startingpositiondiscussion.count.to_s + " records."