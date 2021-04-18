
## our own code (without "top-level" shortcuts e.g. "modular version")
require 'pixelart/base'   # aka "strict(er)" version


###
#  add convenience top-level shortcuts / aliases


### add some spelling convenience variants
PixelArt = Pixelart

module Pixelart
  Palette256 = Palette8Bit = Palette8bit

  class Image
    Palette256 = Palette8Bit = Palette8bit
  end
end


### make Image, Color, Palette8bit, etc top-level
include Pixelart

