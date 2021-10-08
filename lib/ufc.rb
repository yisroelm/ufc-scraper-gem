require_relative "ufc/version"
require "open-uri"
require "nokogiri"
# require "pry"
require "openssl"

module Ufc
  class Error < StandardError; end
  # Your code goes here...
end

require_relative "ufc/cli"
require_relative "ufc/scraper"
require_relative "ufc/fighter"
