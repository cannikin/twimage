module Twimage
  class Yfrog < Twimage::Base
    
    def initialize(service_url)
      @service_url = service_url
      begin
        image_tag = Nokogiri::HTML(open(@service_url.gsub('.com', '.com/z'))).css('#the-image img').first
      rescue OpenURI::HTTPError
        raise ServiceURLInvalid, "The service URL #{@service_url} was not found (returned a 404)"
      end
      
      if image_tag
        @image_url = image_tag['src']
        super
      else
        raise ImageNotFound, "The service URL #{@service_url} did not contain an identifiable image"
      end
    end
    
  end
end