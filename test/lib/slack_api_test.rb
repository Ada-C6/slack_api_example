require 'test_helper'
require 'slack_api_wrapper'
require 'channel'

class SlackApiTest < ActionController::TestCase
  # Just to verify that Rake can pick up the test
  test "the truth" do
     assert true
  end

  test "Retrieve the Channel data" do
    VCR.use_cassette("channels") do
      channels = SlackApiWrapper.list_channels
      assert channels.is_a? Array
      assert channels.length != nil
      channels.each do |channel|
        assert channel.is_a? Slack_Channel

        #Check the ID and name fields
        assert channel.id.present?
        assert channel.name.present?
      end
    end
  end

  test "Retrieve the Channel data with bad token" do
    VCR.use_cassette("bad_channels") do
      channels = SlackApiWrapper.list_channels "BAD_TOKEN"
      assert channels.is_a? Array
      assert channels.length == 0
    end
  end

  test "Can send Messages" do
    VCR.use_cassette("send_messages") do
      response = SlackApiWrapper.send_message("test-api-parens", "This is for a test")
      assert response["ok"]
      assert response["message"]["type"] == "message"
      assert response["message"]["subtype"] == "bot_message"
    end
  end

  test "Bad Messages Don't Work" do
    VCR.use_cassette("send_message_no_channel") do
      response = SlackApiWrapper.send_message("", "This is for a test")
      assert_not response["ok"]
      assert response["error"] == "channel_not_found"
    end

    VCR.use_cassette("send_message_empty_message") do
      response = SlackApiWrapper.send_message("test-api-parens", "")
      assert_not response["ok"]
      assert response["error"] == "no_text"
    end

    VCR.use_cassette("send_message_empty_message") do
      response = SlackApiWrapper.send_message("test-api-parens", nil)
      assert_not response["ok"]
      assert response["error"] == "no_text"
    end
  end



end
