require 'rubygems'
require 'readability'
require 'open-uri'

# load document with Nokogiri
doc = Nokogiri::HTML(open(ARGV.first))

# set Readability parameters
doc.read_style = Readability::Style::NEWSPAPER
doc.read_size = Readability::Size::MEDIUM
doc.read_margin = Readability::Margin::MEDIUM

# Print result after Readability has been run
puts doc.to_readable
