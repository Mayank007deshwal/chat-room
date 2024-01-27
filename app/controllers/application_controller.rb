class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  after_action :set_user_id_cookie, only: [:create], if: -> { user_signed_in? }
  after_action :remove_user_id_cookie, unless: -> { user_signed_in? }
  private

  def set_user_id_cookie
    cookies.signed[:user_id] = current_user.id
  end

  def remove_user_id_cookie
    cookies.signed[:user_id] = nil
  end
end
