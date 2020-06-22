# frozen_string_literal: true

module ApplicationHelper
  def nl2br(str)
    safe_join(str.split(/\R/), tag(:br))
  end
end
