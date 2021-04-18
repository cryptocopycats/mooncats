## 3rd party
require 'chunky_png'

## stdlib
require 'pp'
require 'time'
require 'date'
require 'fileutils'


## our own code
require 'pixelart/version'    # note: let version always go first
require 'pixelart/color'
require 'pixelart/gradient'
require 'pixelart/palette'
require 'pixelart/image'

require 'pixelart/misc'   ## misc helpers


##########
#  add some spelling convenience variants
PixelArt = Pixelart

module Pixelart
  Palette256 = Palette8Bit = Palette8bit

  class Image
    Palette256 = Palette8Bit = Palette8bit
  end
end



puts Pixelart.banner    # say hello
