require "spec_helper"

describe "#options" do

  let(:options){ { "blog_tagline" => "This is a great tagline" } }

  it "#getOptions" do
    VCR.use_cassette("getOptions") do
      CLIENT.getOptions.should include("license" => {"desc"=>"License", "readonly"=>false, "value"=>"MIT"})
    end
  end

  it "#setOptions" do
    VCR.use_cassette("setOptions") do
      CLIENT.setOptions({:options => options}).should include("blog_tagline" => {"desc"=>"Blog Tagline", "readonly"=>false, "value"=>"This is a great tagline"})
    end
  end

end
