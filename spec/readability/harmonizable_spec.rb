require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'open-uri'

describe Readability::Harmonizable do
  before :each do
    @doc = Nokogiri::HTML(open(File.dirname(__FILE__) + '/../files/tomdoc-reasonable-ruby-documentation.html'))
  end
    
  it "extends Nokogiri::HTML::Document" do
    Nokogiri::HTML::Document.include?(Readability::Harmonizable).should be_true
  end

  it "allows access to the DOM" do
    @doc.window.should_not be_nil
    @doc.window.document.should_not be_nil
  end
  
  it "allows changes to the DOM" do
    @doc.window do |window|
      window.document.title = "foobar"
    end
    
    @doc.window.document.title.should == "foobar"
  end

  it "executes javascript code on the document" do
    # check original title
    @doc.window.document.title.should == "TomDoc - Reasonable Ruby Documentation"
    
    # set new title
    @doc.execute_js("document.title = 'foobar'")
    
    # document.title should have new title
    @doc.window.document.title.should == "foobar"
  end
end