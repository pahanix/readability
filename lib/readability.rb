require 'rubygems'
require 'nokogiri'
require 'harmony'

require 'readability/readable'

# Run the Arc90 Lab Experiment Readability on a Nokogiri document.
# TODO: Add example
#
module Readability
end

module Nokogiri
  module HTML
    class Document
      include Readability::Readable
    end
  end
end