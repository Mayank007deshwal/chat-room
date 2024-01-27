class LandingController < ApplicationController
  before_action :authenticate_user!
  def index
    @message = Message.new
    @all_msg = Message.all
  end
end
