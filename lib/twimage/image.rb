module Twimage
  class Image
    
    attr_reader :service, :service_url, :image_url, :tempfile
    
    def initialize(options)
      @service      = options[:service]
      @service_url  = options[:service_url]
      @image_url    = options[:image_url]
      
      extension = @image_url.match(/(\.\w+)(\?|$)/)[1]
      @tempfile = Tempfile.new(['twimage', extension])
      @tempfile << options[:image]
    end
    
  end
end
