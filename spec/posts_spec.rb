require_relative 'spec_helper'

describe "#post" do

  let(:post){ {:post_type => "post", :post_status => "draft", :post_title => "5 Ways to Know You're Cool", :post_content => "I don't always write tests, but when I do, I use RSpec."} }

  let(:post_id) do
    VCR.use_cassette("newPost") do
      CLIENT.newPost({:content => post})
    end
  end

  it "#newPost" do
    post_id.should =~ /#{Date.today.iso8601}-5-ways-to-know-youre-cool/
  end

  it "#getPost" do
    VCR.use_cassette("getPost") do
      CLIENT.getPost({:post_id => post_id}).should include("post_id" => post_id)
    end
  end

  it "#getPosts" do
    VCR.use_cassette("getPosts") do
      CLIENT.getPosts.should include(hash_including("post_id" => post_id))
    end
  end

  it "#editPost" do
    VCR.use_cassette("editPost") do
      CLIENT.editPost({:post_id => post_id, :content => post}).should eq(true)
    end
  end

  it "#deletePost" do
    VCR.use_cassette("deletePost") do
      CLIENT.deletePost({:post_id => post_id}).should eq(true)
    end
  end

  it "#getPostType" do
    VCR.use_cassette("getPostType") do
      CLIENT.getPostType({:post_type_name => "post"}).should include("name"=>"post")
    end
  end

  it "#getPostTypes" do
    VCR.use_cassette("getPostTypes") do
      CLIENT.getPostTypes.should include("post")
    end
  end

  it "#getPostFormats" do
    VCR.use_cassette("getPostFormats") do
      CLIENT.getPostFormats.should include("standard" => "Standard")
    end
  end

  it "#getPostStatusList" do
    VCR.use_cassette("getPostStatusList") do
      CLIENT.getPostStatusList.should include("draft"=>"Draft")
    end
  end

end
