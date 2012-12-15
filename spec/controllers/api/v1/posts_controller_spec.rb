require 'spec_helper'

describe Api::V1::PostsController, api_version: :v1 do
  authorize_request
  let(:user) { FactoryGirl.create(:user) }
  let(:device) { FactoryGirl.create(:device, user_id: user.id) }
  let(:json) { JSON.parse(response.body).with_indifferent_access }
  describe "#create" do
    let(:post_params) { { description: "Awesome description", latitude: 40.7, longitude: 20.8 } }
    let(:params) { { user_id: user.id, post: post_params } }
    before(:each) do
      post :create, params
    end
    it "returns http success" do
      response.should be_success
    end
    it "returns status ok" do
      json[:status].should eq("ok")
    end

  end

  describe "#index" do
    let(:params) { {user_id: user.id}}

    before(:each) do
      FactoryGirl.create(:post, user_id: user.id)
      get :index, params
    end

    it "returns a list of posts" do
      json[:posts].should be_present
    end
  end

  describe "#show" do
    let(:post) { FactoryGirl.create(:post, user_id: user.id) }
    let(:params) { {user_id: user.id, post_id: post.id} }

    before(:each) do
      get :show, params
    end
    it "returns http success" do
      response.should be_success
    end
    it "returns a post" do
      json[:post].should be_present
    end
    it "returns the right post" do
      json[:post][:description].should eq(post.description)
    end
  end

end
