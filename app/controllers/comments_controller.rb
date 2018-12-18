class CommentsController < ApplicationController
  before_action :provide_movie, only: %i[create destroy]
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to @movie
    else
      render 'movies/show'
    end

    def destroy
      @comment = @movie.comments.find(params[:id])

      @comment.destroy!

      redirect_to @movie
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body).merge(movie: @movie)
  end

  def provide_movie
    @movie = Movie.find(params[:movie_id])
  end
end
