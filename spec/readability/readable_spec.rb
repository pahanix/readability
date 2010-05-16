require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'open-uri'

describe Readability::Readable do
  before :each do
    @doc = Nokogiri::HTML(open(File.dirname(__FILE__) + '/../files/tomdoc-reasonable-ruby-documentation.html'))
  end
    
  it "extends Nokogiri::HTML::Document" do
    Nokogiri::HTML::Document.include?(Readability::Readable).should be_true
  end

  it "returns the title of the document" do
    @doc.title.should == "TomDoc - Reasonable Ruby Documentation"   
  end
  
  it "executes javascript code on the document" do
    # check original title
    @doc.execute_js('document.title').should == "TomDoc - Reasonable Ruby Documentation"
    
    # set new title
    @doc.execute_js("document.title = 'foobar'")
    
    # document.title should have new title
    @doc.execute_js('document.title').should == "foobar"
  end
end
