require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  describe "not signed user" do
    let(:user) { FactoryBot.create(:user) }
    let(:movie) { FactoryBot.create(:movie) }

    describe "POST #create" do

      it "doesn't allow to create comment and shows alert" do
        expect do
          post :create, params: { movie_id: movie.id, comment: { body: "Awsome movie!" } }
        end.to_not change(Comment, :count)
        expect(flash[:alert]).to eq "You need to sign in or sign up before continuing."
      end
    end
  end


  describe "signed user" do
    let(:user) { FactoryBot.create(:user) }
    let(:movie) { FactoryBot.create(:movie) }
    before { sign_in(user) }

    describe "POST #create" do

      it "creates comment and redirect" do
        expect do
          post :create, params: { movie_id: movie.id, comment: { body: "What a great movie" } }
        end.to change(Comment, :count).by(1)
        expect(response).to have_http_status(:redirect)
        expect(flash[:notice]). to eq "Comment successfully added"
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

      context "when params has incorrect value"
        it "doesn't create comment" do
          expect do
            post :create, params: { movie_id: movie.id, comment: { body: nil } }
          end.to_not change(Comment, :count)
          expect(response).to render_template("movies/show")
        end
      end

      describe "DELETE #destroy" do
        let(:comment) { FactoryBot.create(:comment, movie: movie, user: user) }
        before { comment }

        it "deletes comment" do
          expect do
            delete :destroy, params: { id: comment.id, movie_id: movie.id }
          end.to change(Comment, :count).by(-1)
          expect(response).to have_http_status(:redirect)
        end

        context "when user is not the author" do
          let(:other_user) { FactoryBot.create(:user) }

          it "doesn't delete comment" do
            sign_in(other_user)

            expect do
              delete :destroy, params: { id: comment.id, movie_id: movie.id }
            end.to_not change(Comment, :count)
            expect(flash[:alert]).to eq "You are not the author of this comment"
          end
        end
      end
    end
  end
