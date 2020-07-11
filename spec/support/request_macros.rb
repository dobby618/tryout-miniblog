# frozen_string_literal: true

module RequestMacros
  def login_user(user)
    sign_in user
  end
end
