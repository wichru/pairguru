class CommentsController < ApplicationController
  before_action :set_movie, only: %i[create destroy]

  def create
    @comment = @movie.comments.create(comment_params)

    if @comment.save
      flash[:notice] = 'Comment successfully added'
      redirect_to @movie
    else
      render 'movies/show'
    end
  end

  def destroy
    @comment = @movie.comments.find(params[:id])

    if @comment.destroy
      flash[:notice] = 'Comment successfully deleted'
    else
      flash[:alert] = 'You are not the author of this comment'
    end
    redirect_to @movie
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end
end
