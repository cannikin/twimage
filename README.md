# Twimage

Twimage provides an easy way to pull raw images from the various Twitter photo image services (twitpic, yfrog, etc.)

## Usage

Add twimage to your Gemfile:

    gem 'twimage'
    
Instantiate the appropriate service and give it the standard URL returned by that service:

    result = Twimage.get('http://instagr.am/p/EHqLG/')
    
Twimage will create a Ruby tempfile with the image. To get the tempfile:

    result.tempfile
    
Save the image to your local system, upload to S3, etc. As soon as there are no more references to the
tempfile in your code it will be unlinked (deleted). There are a couple additional instance variables
you have access to--try result.inspect to take a look.

Enjoy!

## Support

Twimage currently supports the following services:

* twitpic - http://twitpic.com
* yfrog - http://yfrog.com
* instagram - http://instagr.am

## Contributing

To add a parser, fork this repo and then send me a pull request. You should attempt to get the highest resolution
version of the image possible, which isn't always available at the link posted to Twitter. Check out the `SERVICES`
constant in `twimage.rb` for examples of `lambda`s used to modify the original `service_url` to get to the full res
version's URL.
