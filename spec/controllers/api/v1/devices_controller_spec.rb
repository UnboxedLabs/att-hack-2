require 'spec_helper'

describe Api::V1::DevicesController, api_version: :v1 do
  authorize_request

  describe "#create" do
    let(:params) { {device: { uid: "unique" }}}
    let(:json) { JSON.parse(response.body).with_indifferent_access }
    before(:each) do
      post :create, params
    end
    it "returns http success" do
      response.should be_success
    end
    it "contains the user" do
      json[:user].should be_present
    end
    it "contains the device" do
      json[:device].should be_present
    end
    it "assings a device to the user" do
      json[:device][:id].should eq(json[:user][:id])
    end
    it "has a unique name" do
      json[:user][:name].should eq("AnonymousUser#{json[:device][:id]}")
    end
  end

end
