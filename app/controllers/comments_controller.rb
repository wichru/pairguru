class CommentsController < ApplicationController
  before_action :set_movie, only: %i[create destroy]

  def create
<<<<<<< HEAD
<<<<<<< HEAD
    @comment = @movie.comments.new(comment_params.merge(user: current_user))
=======
    @comment = @movie.comments.create(comment_params)
>>>>>>> 8005ca0607cacd99e7edd3ccb2944ec48628d295
=======
    @comment = @movie.comments.create(comment_params)
>>>>>>> 8005ca0607cacd99e7edd3ccb2944ec48628d295

    if @comment.save
      flash[:notice] = 'Comment successfully added'
      redirect_to @movie
    else
      flash.now[:alert] = 'You can only have one comment per movie'
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
<<<<<<< HEAD
<<<<<<< HEAD
    params.require(:comment).permit(:body)
=======
    params.require(:comment).permit(:commenter, :body)
>>>>>>> 8005ca0607cacd99e7edd3ccb2944ec48628d295
=======
    params.require(:comment).permit(:commenter, :body)
>>>>>>> 8005ca0607cacd99e7edd3ccb2944ec48628d295
  end

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end
end
