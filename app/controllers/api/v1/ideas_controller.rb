class Api::V1::IdeasController < Api::V1::ApiController
  def index
    render json: Idea.all
  end

  def create
    render json: Idea.create(idea_params)
  end

  def destroy
    render json: Idea.delete(params[:id])
  end


  private

  # upvote and downvote:
  # if !(idea.swill? && params[:status] == "+1") || !(idea.genius? && params[:status] == "-1")
  # params[:status].increment(quality)
  # end

  def idea_params
    params.require(:idea).permit(:title, :body, :quality)
  end

end
