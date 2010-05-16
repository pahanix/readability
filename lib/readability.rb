# ensure that lib is in the load path
$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'nokogiri'
require 'harmony'

require 'readability/harmonizable'
require 'readability/readable'

# Run the Arc90 Lab Experiment Readability on a Nokogiri document.
# TODO: Add example
#
module Readability
  module Style
    NEWSPAPER = "style-newspaper"
    NOVEL = "style-novel"
    EBOOK = "style-ebook"
    TERMINAL = "style-terminal"
    APERTURA = "style-apertura"
    ATHELAS = "style-athelas"
  end
  
  module Size
    XSMALL = "size-x-small"
    SMALL = "size-small"
    MEDIUM = "size-medium"
    LARGE = "size-large"
    XLARGE = "size-x-large"
  end
  
  module Margin
    XNARROW = "margin-x-narrow"
    NARROW = "margin-narrow"
    MEDIUM = "margin-medium"
    WIDE = "margin-wide"
    XWIDE = "margin-x-wide"
  end
end

class Nokogiri::HTML::Document
  include Readability::Readable
end


