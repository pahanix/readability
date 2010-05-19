module Readability
  module Harmonizable
    def window
      if block_given?
        harmony_page do |page|
          yield page.window
          page.window
        end
      else
        harmony_page.window
      end
    end
    
    def parse string_or_io, url = nil, encoding = nil, options = Nokogiri::XML::ParseOptions::DEFAULT_HTML, &block
      self.root = Nokogiri::HTML::Document.parse(string_or_io, url, encoding, options, &block).root
    end
    
    def execute_js(code)
      result = nil
      
      harmony_page do |page|
        result = page.execute_js(code)
      end
      
      result
    end
    alias :x :execute_js

    def load_js(*paths)
      harmony_page do |page|
        page.load(*paths)
      end
      
      self
    end
    
    def harmony_page
      html = self.to_html

      # unless encoding is already utf[-8], convert using iconv
      unless meta_encoding =~ /utf/i
        begin
          require 'iconv'
          html = Iconv.new("UTF8", "LATIN1//TRANSLIT//IGNORE").iconv(self.to_html)
        rescue 
        end
      end
      
      # load document into a page
      page = Harmony::Page.new(html)
      
      # yield the page and reparse if a block is given
      if block_given?
        yield page
        
        # parse the page back into the document
        parse(page.to_html)
      end
      
      page
    end
  end
end
