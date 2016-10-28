require_relative 'SlackApiWrapper'

class Channel

  attr_reader :name, :id, :purpose, :is_archived, :members

  def initialize(name, id, options = {} )
    @name = name
    @id = id

    @purpose = options[:purpose]
    @is_archived = options[:is_archived]
    @is_general = options[:is_archived]
    @members = options[:members]
  end

  def send_message(text)
    ApiWrapper.sendmsg(id, text)
  end

  def self.all(token)  #all Channels
    token = ENV[org]
    data = ApiWrapper.listchannels(org)
    channels = []
    data.each do |item|
      name = item["name"]
      id = item["id"]
      purpose = item["purpose"]
      is_archived = item["is_archived"]
      members = item["members"]
      channel = Channel.new(name, id, {purpose: purpose, is_archived: is_archived, members: members})
      channels << channel
    end
      # Return All the Slack Channels
    channels
  end

end
