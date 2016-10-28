
require 'httparty'

class SlackApiWrapper
  BASE_URL = "https://slack.com/api/"
  TOKEN  = ENV["TOKEN"]

  attr_reader :name, :id, :purpose, :is_archived, :members

  def initialize(name, id, options = {} )
    @name = name
    @id = id

    @purpose = options[:purpose]
    @is_archived = options[:is_archived]
    @is_general = options[:is_archived]
    @members = options[:members]
  end

  def self.sendmsg(channel, msg, token = nil)
    token = TOKEN if token == nil

    url = BASE_URL + "chat.postMessage?" + "token=#{token}&" + "text=#{msg}&channel=#{channel}&username=CheezItBot"
    data = HTTParty.get(url)
  end

  def self.listchannels(token = nil)
    token ||= TOKEN
    url = BASE_URL + "channels.list?" + "token=#{token}" + "&pretty=1&exclude_archived=1"
    data = HTTParty.get(url)
    channels = []
    if data["channels"]  # if the request was successful
      data["channels"].each do |channel|

        wrapper = self.new channel["name"], channel["id"] #, purpose: channel["purpose"],
        #                 is_archived: channel["is_archived"], members: channel["members"])
        channels << wrapper
      end
     return channels
    else
     return nil
    end
  end
end
