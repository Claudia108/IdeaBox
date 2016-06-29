class Api::V1::IdeasController < Api::V1::ApiController
  def index
    render json: Idea.all
  end

  def create
    render json: Idea.create(idea_params)
  end

  def update
    idea = Idea.find(params[:id])
    if idea.save
      idea.update(idea_params)
      render json: { response: 'success' }
    else
      render json: { response: 'failed' }
    end
  end

  def destroy
    Idea.delete(params[:id])
    render json: params[:id]
  end


  private

  def idea_params
    params.require(:idea).permit(:title, :body, :quality)
  end

end
