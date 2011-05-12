module Twimage
  class Base
    
    attr_accessor :tempfile, :image_url, :service_url, :extension
    
    def initialize(service_url)
      response = HTTParty.get(@image_url)
      @extension = @image_url.match(/(\.\w+)(\?|$)/)[1]
      if response.code == 200
        @tempfile = Tempfile.new(['twimage',@extension])
        @tempfile << response.body.force_encoding('utf-8')
      else
        raise ImageURLInvalid, "The image_url #{@image_url} was not found (returned a 404)"
      end
    end
    
  end
end
