require 'nokogiri'
require 'open-uri'
require 'httparty'
require 'tempfile'
require_relative './twimage/base'
Dir.glob('./twimage/*').each { |f| require_relative f }

module Twimage
  
  class ServiceURLInvalid < StandardError; end  # thrown if the service_url returns a 404
  class ImageNotFound < StandardError; end      # thrown if the service_url doesn't contain an image
  class ImageURLInvalid < StandardError; end    # thrown if the image_url found in the service_url returns a 404

end

# puts Twimage::Twitpic.new('http://twitpic.com/4w30yx').image.inspect