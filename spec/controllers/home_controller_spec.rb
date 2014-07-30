require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'users'" do
    it "returns http success" do
      get 'users'
      response.should be_success
    end
  end

  describe "GET 'students'" do
    it "returns http success" do
      get 'students'
      response.should be_success
    end
  end

  describe "GET 'institutions'" do
    it "returns http success" do
      get 'institutions'
      response.should be_success
    end
  end

end
