class ChatroomsController < ApplicationController

  def index
    @messages = Message.all.order(created_at: :asc)
    @users = User.all.order('LOWER(username)')
  end
end
