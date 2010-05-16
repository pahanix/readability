require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Readability::Readable do
  before :each do
    @doc = Nokogiri::HTML(open(File.dirname(__FILE__) + '/../files/tomdoc-reasonable-ruby-documentation.html'))
  end
    
  it "extends Nokogiri::HTML::Document" do
    Nokogiri::HTML::Document.include?(Readability::Readable).should be_true
  end
  
  it "can set Readability variables" do
    @doc.read_style = Readability::Style::NEWSPAPER
    @doc.read_size = Readability::Size::MEDIUM
    @doc.read_margin = Readability::Margin::MEDIUM
    
    @doc.read_style.should == Readability::Style::NEWSPAPER
    @doc.read_size.should == Readability::Size::MEDIUM
    @doc.read_margin.should == Readability::Margin::MEDIUM
  end
  
  it "can run Readability and return resulting document" do
    # original document includes link to flickr
    @doc.to_html.should include "flickr.com/photos/mojombo"
    
    readable_doc = @doc.to_readable

    # readable version should not include the link to flickr
    readable_doc.should_not be_nil
    readable_doc.to_html.should_not include "flickr.com/photos/mojombo"
  end
  
  it "can run Readability in place" do
    # original document includes link to flickr
    @doc.to_html.should include "flickr.com/photos/mojombo"
    
    @doc.to_readable!
    
    # readable version should not include the link to flickr
    @doc.to_html.should_not include "flickr.com/photos/mojombo"
  end
  
  it "can return the content only" do
    content = @doc.to_readable(:content_only => false)
    content.to_html.should include "Original Page"
    
    content = @doc.to_readable(:content_only => true)
    content.to_html.should_not include "Original Page"
  end
end
