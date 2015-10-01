require 'rails_helper'

describe PostsController do

  describe "GET #new" do

    it "assigns a new post" do
      get :new
      expect(assigns(:post)).to be_a(Post)
    end
  end

  describe "POST #create" do
    it "saves a new post" do
      expect{ post :create, {post: {title: "My post", body: "my body"}} }.to change{Post.count}.by(1)
    end

    it "fails to save a new post" do
      expect{ post :create, {post: {title: "", body: ""}} }.to change{Post.count}.by(0)
    end
  end
end