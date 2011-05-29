require 'nokogiri'
require 'open-uri'
require 'httparty'
require 'tempfile'

$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
require 'twimage/version'
require 'twimage/image'

module Twimage
  
  class ServiceURLInvalid < StandardError; end  # thrown if the service_url returns a 404
  class ImageNotFound < StandardError; end      # thrown if the service_url doesn't contain an expected image tag
  class ImageURLInvalid < StandardError; end    # thrown if the image_url found in the service_url returns a 404
  
  USER_AGENT = "Twimage #{Twimage::VERSION} http://github.com/cannikin/twimage"
  SERVICES = [{ :name => :twitpic,
                :service_match => /twitpic\.com/,
                :full_url_modifier => lambda { |url| url + '/full' },
                :image_css_match => 'body > img' },
              { :name => :yfrog,
                :service_match => /yfrog\.com/,
                :full_url_modifier => lambda { |url| url.gsub(/\.com/, '.com/z') },
                :image_css_match => '#the-image img' },
              { :name => :instagram,
                :service_match => [/instagr\.am/, /instagram\.com/],
                :image_css_match => '.photo'}]
                  
  def self.get(url)
    service_url = HTTParty.get(url, :headers => { 'User-Agent' => USER_AGENT }).request.path.to_s                                                                 # first point HTTParty at this URL and follow any redirects to get to the final page
    service = find_service(service_url)                                                                               # check the resulting service_url for which service we're hitting
    full_res_service_url = service[:full_url_modifier] ? service[:full_url_modifier].call(service_url) : service_url  # get the full res version of the service_url
    image_url = get_image_url(service, full_res_service_url)                                                          # get the URL to the image
    image = get_image(image_url)                                                                                      # get the image itself
    
    return Image.new(:service => service[:name], :service_url => service_url, :image_url => image_url, :image => image)
  end
  
  
  # figure out which service this is by matching against regexes
  def self.find_service(url)
    return SERVICES.find do |service|
      [service[:service_match]].flatten.find do |regex|
        url.match(regex)
      end
    end
  end
  
  
  # tear apart the HTML on the returned service page and find the source of the image
  def self.get_image_url(service, url)
    # get the content of the image page
    begin
      image_tag = Nokogiri::HTML(open(url, 'User-Agent' => USER_AGENT)).css(service[:image_css_match]).first
    rescue OpenURI::HTTPError
      raise ServiceURLInvalid, "The service URL #{url} was not found (returned a 404)"
    end
    
    # get the URL to the actual image file
    if image_tag
      return image_tag['src']
    else
      raise ImageNotFound, "The service URL #{url} did not contain an identifiable image"
    end
  end
  

  # download the actual image and put into a tempfile
  def self.get_image(url)
    # get the image itself
    response = HTTParty.get(url, :headers => { 'User-Agent' => USER_AGENT })
    if response.code == 200
      return response.body.force_encoding('utf-8')
    else
      raise ImageURLInvalid, "The image_url #{url} was not found (returned a 404)"
    end
  end
  
end
