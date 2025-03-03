require_relative 'spec_helper'

describe "#taxonomies" do

  let(:term){ {:name => "Geraffes", :taxonomy => "category"} }
  let(:edited_term){ {:name => "gazelles", :taxonomy => "category"} }

  it "#newTerm" do
    VCR.use_cassette("newTerm") do
      Proc.new do
        TERM_ID = CLIENT.newTerm({:content => term})
        # TERM_ID.should =~ STRING_NUMBER_REGEX
      end.should raise_error(RuntimeError)
    end
  end

  it "#getTaxonomy" do
    VCR.use_cassette("getTaxonomy") do
      CLIENT.getTaxonomy(taxonomy: "category").should include("label" => "Categories")

      Proc.new do
        CLIENT.getTaxonomy(taxonomy: "actor").should include("label" => "Categories")
      end.should raise_error(RuntimeError)
    end
  end

  it "#getTaxonomies" do
    VCR.use_cassette("getTaxonomies") do
      CLIENT.getTaxonomies[0].should include("name"=>"category")
    end
  end

  it "#getTerm" do
    VCR.use_cassette("getTerm") do
      Proc.new do
        CLIENT.getTerm({:term_id => 1}).should include("name"=>"Uncategorized")
      end.should raise_error(RuntimeError)
    end
  end

  it "#getTerms" do
    VCR.use_cassette("getTerms") do
      Proc.new do
        CLIENT.getTerms[0].should include("taxonomy"=>"category")
      end.should raise_error(RuntimeError)
    end
  end

  it "#editTerm" do
    VCR.use_cassette("editTerm") do
      Proc.new do
        CLIENT.editTerm({:term_id => 1, :content => edited_term}).should eq(true)
      end.should raise_error(RuntimeError)
    end
  end

  it "#deleteTerm" do
    VCR.use_cassette("deleteTerm") do
      Proc.new do
        CLIENT.deleteTerm({:term_id => 1, :taxonomy => "category"}).should eq(true)
      end.should raise_error(RuntimeError)
    end
  end

end
