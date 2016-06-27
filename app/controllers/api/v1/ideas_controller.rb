class Api::V1::IdeasController < Api::V1::BaseController

  def index
    # ideas = Idea.all
    respond_with Idea.all 
  end

end
