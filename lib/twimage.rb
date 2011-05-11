require 'nokogiri'
require 'open-uri'
require 'httparty'
require 'tempfile'

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
  
require 'twimage/base'
require 'twimage/twitpic'
require 'twimage/version'

module Twimage
  
  class ServiceURLInvalid < StandardError; end  # thrown if the service_url returns a 404
  class ImageNotFound < StandardError; end      # thrown if the service_url doesn't contain an image
  class ImageURLInvalid < StandardError; end    # thrown if the image_url found in the service_url returns a 404

end

# puts Twimage::Twitpic.new('http://twitpic.com/4w30yx').image.inspect