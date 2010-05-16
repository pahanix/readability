module Readability
  module Readable
    include Readability::Harmonizable

    def read_style
      @read_style ||= Readability::Style::NEWSPAPER
    end
    
    def read_size
      @read_size ||= Readability::Size::MEDIUM
    end
    
    def read_margin
      @read_margin ||= Readability::Margin::MEDIUM
    end

    attr_writer :read_style, :read_size, :read_margin
    
    def to_readable(args = {})
      args[:content_only] ||= false
      
      # dup document
      readable_doc = self.dup
      
      # remove all script tags
      readable_doc.xpath('//script').each { |node| node.remove }
      
      readable_doc.harmony_page do |page|
        # Set parameters
        page.window.readStyle = @read_style
        page.window.readSize = @read_size
        page.window.readMargin = @read_margin
        
        # execute readability.js
        page.load(File.join(File.dirname(__FILE__), 'js', 'readability.js'))
      end
      
      # return <div id="readInner">...</div> if content_only
      if args[:content_only]
        return readable_doc.at_css("#readInner")
      end
      
      # return document
      readable_doc
    end
    
    def to_readable!(args = {})
      self.root = to_readable(args).root
    end
  end
end