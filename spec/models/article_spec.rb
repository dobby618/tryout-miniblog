# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article, type: :model do
  describe '#self.notify_like_ranking_of_yesterday' do # 前日の「いいね」ランキングを通知する
    context '前日に「いいね」がある場合' do
      before do
        create(:like, created_at: Time.current.ago(1.day))
      end

      it '全ユーザに「いいね」ランキングメールを通知すること' do
        expect do
          described_class.notify_like_ranking_of_yesterday
        end.to change(ActionMailer::Base.deliveries, :count).by(User.count)
      end
    end

    context '前日に「いいね」がない場合' do
      it '「いいね」ランキングメールを通知しないこと' do
        expect do
          described_class.notify_like_ranking_of_yesterday
        end.not_to change(ActionMailer::Base.deliveries, :count)
      end
    end
  end

  describe '#self.like_ranking_of_yesterday' do # 昨日の「いいね」数順に並んだ上位 N 件
    describe '昨日の「いいね」だけカウントする' do
      context '昨日「いいね」が 10 件の article1 と一昨日「いいね」が 20 件の article2 があった場合' do
        let(:article1) { create(:article) }
        let(:article2) { create(:article) }

        before do
          create_list(:like, 10, article: article1, created_at: Time.current.ago(1.day))
          create_list(:like, 20, article: article2, created_at: Time.current.ago(2.days))
        end

        it '1 位が article1 であること' do
          expect(described_class.like_ranking_of_yesterday.first).to eq article1
        end
      end
    end

    describe '引数の指定' do
      context '昨日「いいね」された記事数が 10 件以上の場合' do
        before do
          create_list(:like, 10, created_at: Time.current.ago(1.day))
        end

        context '引数を指定しない場合' do
          it '10 件の記事が返ること' do
            expect(described_class.like_ranking_of_yesterday.count).to eq 10
          end
        end

        context '引数に 5 を指定した場合' do
          it '5 件の記事が返ること' do
            expect(described_class.like_ranking_of_yesterday(5).count).to eq 5
          end
        end
      end
    end

    describe '記事の並び順' do
      context '昨日「いいね」された記事が 2 件存在した場合' do
        let(:article1) { create(:article) }
        let(:article2) { create(:article) }

        before do
          create_list(:like, 10, article: article1, created_at: Time.current.ago(1.day))
          create_list(:like, 20, article: article2, created_at: Time.current.ago(1.day))
        end

        it '1 位が article2 であること' do
          expect(described_class.like_ranking_of_yesterday.first).to eq article2
        end

        it '2 位が article1 であること' do
          expect(described_class.like_ranking_of_yesterday.second).to eq article1
        end
      end
    end
  end

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
