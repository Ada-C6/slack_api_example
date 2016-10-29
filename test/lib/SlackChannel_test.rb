require 'test_helper'
require "channel"


class SlackChannelTest < ActionController::TestCase
  # Just to verify that Rake can pick up the test
  test "the truth" do
     assert true
  end

  # Attributes:
  #   attr_reader :name, :id, :purpose, :is_archived, :members

  test "Creating a Channel without proper parameters triggers an ArgumentError" do
    assert_raises ArgumentError do
      test_channel = Slack_Channel.new
    end
    assert_raises ArgumentError do
      test_channel = Slack_Channel.new "test-api-parens"
    end
    assert_raises ArgumentError do
      test_channel = Slack_Channel.new "", ""
    end
    assert_raises ArgumentError do
      test_channel = Slack_Channel.new nil, nil
    end
  end

  test "Getting the channel name works properly" do
    channel = Slack_Channel.new( "Parens Rock", "12345")

    assert_equal channel.name, "Parens Rock"
  end

  test "Getting the channel id works properly" do
    channel = Slack_Channel.new("Parens Rock", "12345")

    assert_equal channel.id, "12345"
  end
  test "Getting the channel purpose works properly" do
    channel = Slack_Channel.new("Parens Rock", "12345", purpose: "To rock")

    assert_equal channel.purpose, "To rock"
  end

  test "Getting the channel is_archived works properly" do
    channel = Slack_Channel.new("Parens Rock", "12345", is_archived: "1")

    assert_equal channel.is_archived, "1"
  end

  test "Getting the channel members works properly" do
    channel = Slack_Channel.new("Parens Rock", "12345", members: ["Ada", "Carl", "Kari"])

    assert_equal channel.members, ["Ada", "Carl", "Kari"]
  end
end
