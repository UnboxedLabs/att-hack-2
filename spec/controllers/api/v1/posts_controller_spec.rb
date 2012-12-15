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
    let(:params) { {user_id: user.id, latitude: 2.0, longitude: 2.0, radius: 50 } }

    before(:each) do
      FactoryGirl.create(:post, user_id: user.id)
      get :index, params
    end

    it "is a successful call" do
      puts "JSON #{json}"
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

  describe "#up_vote" do
    let(:new_post) { FactoryGirl.create(:post, user_id: user.id) }
    let(:params) { { user_id: user.id, post_id: new_post.id } }
    it "changes the votes for the post" do
      votes = new_post.up_votes
      post :up_vote, params
      new_post.reload.up_votes.should_not eq(votes)
    end
    it "returns ok" do
      post :up_vote, params
      response.should be_success
    end
  end

  describe "#down_votes" do
    let(:new_post) { FactoryGirl.create(:post, user_id: user.id) }
    let(:params) { { user_id: user.id, post_id: new_post.id } }
    it "changes teh votes for the post" do
      votes = new_post.down_votes
      post :down_vote, params
      new_post.reload.down_votes.should_not eq(votes)
    end
    it "returns ok" do
      post :down_vote, params
      response.should be_success
    end
  end

end
