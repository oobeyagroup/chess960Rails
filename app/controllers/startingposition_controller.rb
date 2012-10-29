class StartingpositionController < ApplicationController

def discuss
  @board_positions = Startingpositiondiscussion.all
end

def show
  @board_position = Startingpositiondiscussion.where(:startingpostionnumber => params[:spid].to_i).first

end

end
