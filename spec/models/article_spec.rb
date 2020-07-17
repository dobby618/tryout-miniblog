# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article, type: :model do
  describe '#liked?' do # 「いいね」の可否
    let(:article) { create(:article) }
    let(:argument_user) { create(:user) }

    context '投稿が引数のユーザに「いいね」されている場合' do
      before do
        create(:like, article: article, user: argument_user)
      end

      it 'true であること' do
        expect(article.liked?(argument_user)).to eq true
      end
    end

    context '投稿が引数のユーザに「いいね」されていない場合' do
      it 'false であること' do
        expect(article.liked?(argument_user)).to eq false
      end
    end
  end
end
