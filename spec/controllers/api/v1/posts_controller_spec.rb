require 'spec_helper'

describe Api::V1::PostsController, api_version: :v1 do
  authorize_request
  describe "#create" do
    let(:user) { FactoryGirl.create(:user) }
    let(:device) { FactoryGirl.create(:device) }

    let(:post_params) { { description: "Awesome description", latitude: 40.7, longitude: 20.8 } }
    let(:params) { { device_id: device.id, post: post_params } }
    let(:json) { JSON.parse(response.body).with_indifferent_access }
    before(:each) do
      device.user = user
      device.save!
      post :create, params
    end
    it "returns http success" do
      response.should be_success
    end
    it "returns status ok" do
      json[:status].should eq("ok")
    end

  end
  #
  #describe "GET 'index'" do
  #  it "returns http success" do
  #    get 'index'
  #    response.should be_success
  #  end
  #end
  #
  #describe "GET 'show'" do
  #  it "returns http success" do
  #    get 'show'
  #    response.should be_success
  #  end
  #end

end
