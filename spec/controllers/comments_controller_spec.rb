require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    before do
      @genre = Genre.create!(name: 'Fancy movie')
      @movie = Movie.create!(
        title: "Pulp Fiction",
        description: "This should be some movie description",
        genre_id: @genre.id
      )
    end

    it "creates comment and redirect" do
      expect do
        post :create, params: { comment: { commenter: 'Joe', body: "What a great movie", movie_id: @movie.id } }
      end.to change(Comment, :count).by(1)
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "DELETE #destroy" do
    before do
      @genre = Genre.create!(name: 'Fancy movie')
      @movie = Movie.create!(
        title: "Pulp Fiction",
        description: "This should be some movie description",
        genre_id: @genre.id
      )
    end

    it "deletes comment" do
      comment = Comment.create(commenter: 'Joe', body: "What a great movie", movie_id: @movie.id)

      expect do
        delete :destroy, params: { id: comment }
      end.to change(Comment, :count).by(-1)
      expect(response).to be_successful
    end

    it "deletes comment and redirect" do
      comment = Comment.create(commenter: 'Joe', body: "What a great movie", movie_id: @movie.id)

      expect do
        delete :destroy, params: { id: comment }
      end.to change(Comment, :count).by(-1)
      expect(response).to have_http_status(:redirect)
    end
  end
end
