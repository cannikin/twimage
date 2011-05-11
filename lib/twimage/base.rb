module Twimage
  class Base
    
    attr_accessor :image, :image_url, :service_url
    
    def initialize(service_url)
      response = HTTParty.get(@image_url)
      puts response.code
      if response.code == 200
        @image = Tempfile.new(['twimage','.jpg'])
        @image << response.body
      else
        raise ImageURLInvalid, "The image_url #{@image_url} was not found (returned a 404)"
      end
    end
    
  end
end
