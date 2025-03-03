require_relative 'spec_helper'

describe "#comments" do

  let(:post_id){ 1 }
  let(:comment){ {:comment_parent => "", :content => "This is a test thing here.", :author => "John Adams", :author_url => "http://johnadamsforpresidentnow.com", :author_email => "johnadams@whitehouse.gov"} }

  it "#newComment" do
    VCR.use_cassette("newComment") do
      Proc.new do
        COMMENT_ID = CLIENT.newComment({:post_id => post_id, :comment => comment})
        # COMMENT_ID.class.should eq(Integer)
      end.should raise_error(RuntimeError)
      CLIENT.instance_eval { @connection }.http_last_response.code.should eq "422"

    end
  end

  it "#editComment" do
    VCR.use_cassette("editComment") do
      Proc.new do
        CLIENT.editComment({:comment_id => 1, :comment => comment}).class.should eq(TrueClass)

      end.should raise_error(RuntimeError)
      CLIENT.instance_eval { @connection }.http_last_response.code.should eq "422"

    end
  end

  it "#getCommentCount" do
    VCR.use_cassette("getCommentCount") do
      Proc.new do
        CLIENT.getCommentCount({:post_id => post_id}).should include("approved")

      end.should raise_error(RuntimeError)
      CLIENT.instance_eval { @connection }.http_last_response.code.should eq "422"

    end
  end

  it "#getComment" do
    VCR.use_cassette("getComment") do
      Proc.new do
        CLIENT.getComment({:comment_id => 1}).should include("content" => "This is a test thing here.")

      end.should raise_error(RuntimeError)
      CLIENT.instance_eval { @connection }.http_last_response.code.should eq "422"

    end
  end

  it "#getComments" do
    VCR.use_cassette("getComments") do
      Proc.new do
        CLIENT.getComments[0].should include("post_id" => post_id.to_s)

      end.should raise_error(RuntimeError)
      CLIENT.instance_eval { @connection }.http_last_response.code.should eq "422"

    end
  end

  it "#deleteComment" do
    VCR.use_cassette("deleteComment") do
      Proc.new do
        CLIENT.deleteComment({:comment_id => 1}).class.should eq(TrueClass)

      end.should raise_error(RuntimeError)
      CLIENT.instance_eval { @connection }.http_last_response.code.should eq "422"

    end
  end

  it "#getCommentStatusList" do
    VCR.use_cassette("getCommentStatusList") do
      Proc.new do
        CLIENT.getCommentStatusList.should include("hold" => "Unapproved")

      end.should raise_error(RuntimeError)
      CLIENT.instance_eval { @connection }.http_last_response.code.should eq "422"

    end
  end

end
