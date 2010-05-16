require 'rubygems'
require 'nokogiri'
require 'harmony'

require 'readability/harmonizable'
require 'readability/readable'

# Run the Arc90 Lab Experiment Readability on a Nokogiri document.
# TODO: Add example
#
module Readability
end

class Nokogiri::HTML::Document
  include Readability::Harmonizable
end


