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
require 'pixelart/image'





### add some convenience shortcuts
PixelArt = Pixelart



puts Pixelart.banner    # say hello
