require 'test_helper'

describe HomepagesController do
  it "should get index" do
    get homepages_index_path
    must_respond_with :success
  end

  it "should get new" do
    get homepages_new_path
    must_respond_with :success
  end

  it "should get create" do
    get homepages_create_path
    must_respond_with :success
  end

end
