# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_account_update_params, only: [:update]

  def update
    super
  end

  private

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:profile, :website])
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def after_sign_up_path_for(_resource)
    root_url
  end

  def after_update_path_for(resource)
    profile_url(resource)
  end
end
