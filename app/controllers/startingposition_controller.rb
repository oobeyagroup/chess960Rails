class StartingpositionController < ApplicationController

def discuss
  @board_positions = Startingpositiondiscussion.all
end

def show
  @position = params[:spid].to_i
  @board_position = Startingpositiondiscussion.where(:startingpostionnumber => @position).first

end

end
