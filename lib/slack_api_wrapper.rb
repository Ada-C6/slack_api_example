
require 'httparty'

require "#{Rails.root}/lib/channel.rb"


class SlackApiWrapper
  BASE_URL = "https://slack.com/api/"
  TOKEN  = ENV["TOKEN"]




  def self.send_message(channel, msg, token = nil)
    token = TOKEN if token == nil

    url = BASE_URL + "chat.postMessage?" + "token=#{token}&" + "text=#{msg}&channel=#{channel}&username=CheezItBot"
    data = HTTParty.get(url)
  end

  def self.list_channels(token = nil)
    token ||= TOKEN
    url = BASE_URL + "channels.list?" + "token=#{token}" + "&pretty=1&exclude_archived=1"
    data = HTTParty.get(url)
    channels = []
    if data["channels"]  # if the request was successful
      data["channels"].each do |channel|
        wrapper = Slack_Channel.new channel["name"], channel["id"] , purpose: channel["purpose"], is_archived: channel["is_archived"], members: channel["members"]
        channels << wrapper
      end
     return channels
    else
     return []
    end
  end
end
