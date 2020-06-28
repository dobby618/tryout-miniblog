# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#followed?' do # フォローしていることを確認する
    let(:user) { create(:user) }
    let(:argument_user) { create(:user) }

    context 'ユーザが引数のユーザをフォローしている場合' do
      before do
        create(:follow, user: user, follow_user: argument_user)
      end

      it 'true であること' do
        expect(user.followed?(argument_user)).to eq true
      end
    end

    context 'ユーザが引数のユーザをフォローしていない場合' do
      it 'false であること' do
        expect(user.followed?(argument_user)).to eq false
      end
    end
  end
end
