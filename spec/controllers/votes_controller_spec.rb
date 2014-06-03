require 'spec_helper'

describe VotesController do

  let!(:question){create(:question)}

  describe "POST #like" do

    context "Registered User likes question" do
      before do
        login_user
      end

      it "assigns needed variables" do
        xhr :post, :like, user: @user, question_id: question, format: :js
        expect(assigns(:votable)).to eq question
        expect(assigns(:value)).to eq 1
      end

      it "save a new vote to database" do
        expect { xhr :post, :like, user: @user, question_id: question, format: :js }.to change(question.votes, :count).by(1)
      end

    end

  end

end
