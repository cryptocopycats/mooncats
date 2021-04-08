## 3rd party
require 'chunky_png'

## stdlib
require 'pp'

## our own code
require 'pixelart/version'    # note: let version always go first



module Pixelart
class Image

def initialize( pixels, colors:, zoom: 1 )
  @colors = parse_colors( colors )
  @pixels = parse_pixels( pixels )

  max_width  = @pixels.reduce(1) {|max_width,row| row.size > max_width ? row.size : max_width }
  max_height = @pixels.size

  @img = ChunkyPNG::Image.new( max_width*zoom,
                               max_height*zoom,
                               ChunkyPNG::Color::TRANSPARENT )

  @pixels.each_with_index do |row,y|
    row.each_with_index do |color,x|
      pixel = @colors[color]
      zoom.times do |n|
        zoom.times do |m|
          @img[n+zoom*x,m+zoom*y] = pixel
        end
      end
    end # each row
  end # each data
end


def parse_pixels( pixels )
   data = []
   pixels.each_line do |line|
     line = line.strip
     if line.empty?
       puts "!! WARN: skipping empty line in pixel art source"
       next
     end

     ## note: allow multiple spaces or tabs to separate pixel codes
     ##  e.g.   o o o o o o o o o o o o dg lg w w lg w lg lg dg dg w w  lg dg o o o o o o o o o o o
     ##    or
     data << line.split( /[ \t]+/)
  end
  data
end


#####
# (image) delegates
##   todo/check: add some more??
def save( path, constraints = {} )
  @img.save( path, constraints )
end

def width()        @img.width; end
def height()       @img.height; end

## return image ref - use a different name - why? why not?
def image()        @img; end

def colors()       @colors; end     ## todo/check - return color map (hash table) or just color values (array) - why? why not?



######
# helpers
def parse_colors( colors )
  if colors.is_a?( Array )   ## convenience shortcut
    ## note: always auto-add color 0 as pre-defined transparent - why? why not?
    h = { '0' => ChunkyPNG::Color::TRANSPARENT }
    colors.each_with_index do |color, i|
       h[ (i+1).to_s ] = parse_color( color )
    end
    h
  else  ## assume hash table with color map
    ## convert into ChunkyPNG::Color
    colors.map do |key,color|
      ## always convert key to string why? why not?  use symbol?
      [ key.to_s, parse_color( color ) ]
    end.to_h
  end
end

def parse_color( color )
  if color.is_a?( Integer )  ## e.g. Assumess ChunkyPNG::Color.rgb() or such
    color ## pass through as is 1:1
  elsif color.is_a?(String)
    if color.downcase == 'transparent'   ## special case for builtin colors
      ChunkyPNG::Color::TRANSPARENT
    else
      ## note: return an Integer !!! (not a Color class or such!!! )
      ChunkyPNG::Color.from_hex( color )
    end
  else
    raise ArgumentError, "unknown color format; cannot parse - expected rgb hex string e.g. d3d3d3"
  end
end


end # class Image
end  # module Pixelart



### add some convenience shortcuts
PixelArt = Pixelart



puts Pixelart.banner    # say hello
