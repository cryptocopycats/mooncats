
module Mooncats
class Image
class Composite    ## nest Composite inside Image - why? why not?


CANVAS_WIDTH  = 24    ## sorry - for now "hard-coded" / fixed - 24x24
CANVAS_HEIGHT = 24

def initialize( cols=100, rows=255 )
    @composite = ChunkyPNG::Image.new( cols*CANVAS_WIDTH,
                                       rows*CANVAS_HEIGHT,
                                       ChunkyPNG::Color::TRANSPARENT ) # why? why not? - use TRANSPARENT (is default?)

    ## todo/check - find a better name for cols/rows - why? why not?
    @cols = cols
    @rows = rows

    @i = 0  # (track) current index (of added images)
end


def add( image )
  y, x =  @i.divmod( @cols )

  puts "    width: #{image.width}, height: #{image.height}"

  ## try to center image (identicon) in 24x24 canvas
  ##   the 4 formats are
  ##   - 21×17 - Standing
  ##   - 20×14 - Sleeping
  ##   - 17×22 - Pouncing
  ##   - 20×21 - Stalking
  ## e.g. add left padding (x_center) and
  ##          top padding (y_center)
  x_center, y_center = case [image.width, image.height]
                       when [21,17] then [1,3]
                       when [20,14] then [2,5]
                       when [17,22] then [3,1]
                       when [20,21] then [2,1]
                       ## todo/fix: report unknown image format/size!!!!
                       end

  ## note: image.image  - "unwrap" the "raw" ChunkyPNG::Image
  @composite.compose!( image.image, x*CANVAS_WIDTH+x_center, y*CANVAS_HEIGHT+y_center )
  @i += 1
end

alias_method :<<, :add



#####
# (image) delegates
##   todo/check: add some more??
def save( path, constraints = {} )
  @composite.save( path, constraints )
end

def width()        @composite.width; end
def height()       @composite.height; end

## return image ref - use a different name - why? why not?
def image()        @composite; end


end # class Composite
end # class Image
end # module Mooncats