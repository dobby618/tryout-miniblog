# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Like', type: :request do
  describe 'POST #create' do
    let(:current_user) { create(:user) }

    before do
      login_user(current_user)
    end

    context '自分以外のユーザの投稿に「いいね」した場合' do
      # TODO: Post クラスを Article に変更したい
      # let(:post) すると http の post メソッドと重複して使えなくなるので不便。
      let(:article) { create(:post, user: create(:user)) }

      it '「いいね」できる' do
        expect { post post_like_url(article) }.to change(Like, :count).by(1)
      end
    end

    context '自分の投稿に「いいね」した場合' do
      let(:article) { create(:post, user: current_user) }

      it '「いいね」できない' do
        expect { post post_like_url(article) }.not_to change(Like, :count)
      end
    end
  end
end
