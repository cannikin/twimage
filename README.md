# Twimage

Twimage provides an easy way to pull raw images from the various Twitter photo image services (twitpic, yfrog, etc.)

## Usage

Add twimage to your Gemfile:

    gem 'twimage'
    
Instantiate the appropriate service and give it the standard URL returned by that service:

    result = Twimage::Twitpic.new('http://twitpic.com/4w30yx')
    
Twimage will create a Ruby tempfile with the image. To get the tempfile:

    result.tempfile
    
Save the image to your local system, upload to S3, etc. As soon as there are no more references to the
tempfile in your code it will be unlinked (deleted). Enjoy!

## Support

Twimage currently supports the following services:

* twitpic - http://twitpic.com
* yfrog - http://yfrog.com

## Contributing

To add a parser, fork this repo and then send me a pull request. Your parser should make a reasonable attempt to
retrieve the highest resolution image possible and return errors if the service URL returns a 404 or the proper 
image tag couldn't be found (see twitpic.rb for an example).
