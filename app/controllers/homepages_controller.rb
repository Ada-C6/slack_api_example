require "#{Rails.root}/lib/SlackApiWrapper.rb"

class HomepagesController < ApplicationController
  def index
    @data = SlackApiWrapper.list_channels
    if @data != nil && @data != []
      render status: :created
    else
      render status: :service_unavailable
    end
  end

  def new
    @channel = params[:channel]
    @channel_id = params[:id]
  end

  def create
    result = SlackApiWrapper.sendmsg(params["channel"], params["message"])
    if result["ok"]
      flash[:notice] = "Message Sent"
    else
      flash[:notice] = "Message Failed to Send #{results['ok']}"
    end
    redirect_to :root
  end
end
