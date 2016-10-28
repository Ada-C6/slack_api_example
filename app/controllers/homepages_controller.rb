require "#{Rails.root}/lib/SlackApiWrapper.rb"
require "#{Rails.root}/lib/channel.rb"



class HomepagesController < ApplicationController
  def index
    @data = SlackApiWrapper.listchannels
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
      resp = :created
    else
      resp = :service_unavailable
    end
    raise
    redirect_to root_path, resp
  end
end
