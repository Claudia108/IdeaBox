class Api::V1::IdeasController < Api::V1::ApiController
  def index
    render json: Idea.all
  end

  def create
    render json: Idea.create(idea_params)
  end

  def update
    render json: Idea.update(params[:id], idea_params)
    #  { response: 'success' }
    # else
    #   render json: { response: 'failed' }
    # end
  end

  #  def update
  #   if idea_params[:quality]
  #     render json: Idea.update(params[:id], quality: idea_params[:quality].to_i)
  #   else
  #     render json: Idea.update(params[:id], idea_params)
  #   end
  # end

  def destroy
    Idea.delete(params[:id])
    render json: params[:id]
  end


  private

  def idea_params
    params.require(:idea).permit(:title, :body, :quality)
  end

end
