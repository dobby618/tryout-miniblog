# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comment', type: :request do
  describe 'POST #create' do
    let(:current_user) { create(:user) }

    before do
      login_user(current_user)
    end

    context '自分以外のユーザにコメントした場合' do
      let(:article) { create(:article, user: create(:user)) }
      let(:params) { { comment: { body: Faker::Name.name } } }

      it '通知メールを送信する' do
        expect do
          post article_comments_url(article, params)
        end.to change(ActionMailer::Base.deliveries, :size).by(1)
      end
    end

    context '自分の投稿にコメントした場合' do
      let(:article) { create(:article, user: current_user) }
      let(:params) { { comment: { body: Faker::Name.name } } }

      it '通知メールを送信しない' do
        expect do
          post article_comments_url(article, params)
        end.not_to change(ActionMailer::Base.deliveries, :size)
      end
    end
  end
end
