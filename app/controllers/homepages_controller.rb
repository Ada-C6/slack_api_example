require "#{Rails.root}/lib/SlackApiWrapper.rb"
require "#{Rails.root}/lib/channel.rb"



class HomepagesController < ApplicationController
  def index
    @data = SlackApiWrapper.listchannels
  end

  def new
    @channel = params[:channel]
    @channel_id = params[:id]
  end

  def create
    result = SlackApiWrapper.sendmsg(params["channel"], params["message"])
    raise
    redirect_to root_path
  end
end
