require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  describe "POST #create" do
    let(:user) { FactoryBot.create(:user) }
    let(:movie) { FactoryBot.create(:movie) }
    before do
      sign_in(user)
    end

    context "when user already created a comment" do
      it "doesn't allow to create another" do
        FactoryBot.create(:comment, movie: movie, user: user)
        expect do
          post :create, params: { movie_id: movie.id, comment: { body: "What a great movie" } }
        end.not_to change(Comment, :count)
        expect(response).to render_template('movies/show')
        expect(flash[:alert]).to eq "You can only have one comment per movie"
      end
    end

    it "creates comment and redirect" do
      expect do
        post :create, params: { movie_id: movie.id, comment: { body: "What a great movie" } }
      end.to change(Comment, :count).by(1)
      expect(response).to have_http_status(:redirect)
      expect(flash[:notice]). to eq "Comment successfully added"
    end

    context "when params has incorrect value"
      it "doesn't create comment" do
        expect do
          post :create, params: { movie_id: movie.id, comment: { body: nil } }
        end.to_not change(Comment, :count)
        expect(response).to render_template("movies/show")
      end
    end

  describe "DELETE #destroy" do
    let(:user) { FactoryBot.create(:user) }
    let(:movie) { FactoryBot.create(:movie) }
    before do
      sign_in(user)
    end

    it "deletes comment" do
      comment = FactoryBot.create(:comment, movie: movie, user: user)

      expect do
        delete :destroy, params: { id: comment.id, movie_id: movie.id }
      end.to change(Comment, :count).by(-1)
      expect(response).to have_http_status(:redirect)
    end
  end
end
