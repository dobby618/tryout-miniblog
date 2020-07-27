# frozen_string_literal: true

namespace :cron do
  desc '前日の「いいね」ランキングをユーザに通知する'
  task notify_like_ranking_of_yesterday: :environment do
    Article.notify_like_ranking_of_yesterday
  end
end
