module Readability
  module Readable
    def harmony_page
      @harmony_page ||= Harmony::Page.new(self.to_html)
    end
  end
end