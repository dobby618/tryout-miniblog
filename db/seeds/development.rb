# frozen_string_literal: true

# ランキングバッチのためのテストデータ
# 前日の「いいね」された記事を作成する
FactoryBot.create_list(:article, 10) if Article.count < 10
100.times do
  Like.create(user_id: User.ids.sample,
              article_id: Article.ids.sample,
              created_at: DateTime.current.ago(1.day))
end
