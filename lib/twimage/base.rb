module Twimage
  class Base
    
    attr_accessor :tempfile, :image_url, :service_url
    
    def initialize(service_url)
      response = HTTParty.get(@image_url)
      puts response.code
      if response.code == 200
        @tempfile = Tempfile.new(['twimage','.jpg'])
        @tempfile << response.body.force_encoding('utf-8')
      else
        raise ImageURLInvalid, "The image_url #{@image_url} was not found (returned a 404)"
      end
    end
    
  end
end
