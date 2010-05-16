require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'open-uri'

describe Readability::Readable do
  it "extends Nokogiri::HTML::Document" do
    Nokogiri::HTML::Document.include?(Readability::Readable).should be_true
  end
  
  it "loads the document into Harmony" do
    doc = Nokogiri::HTML(open(File.dirname(__FILE__) + '/../files/tomdoc-reasonable-ruby-documentation.html'))
    doc.harmony_page.should_not be_nil
    doc.harmony_page.document.title.should == "TomDoc - Reasonable Ruby Documentation"
  end
end
