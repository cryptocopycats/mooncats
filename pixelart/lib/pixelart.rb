## 3rd party
require 'chunky_png'

## stdlib
require 'pp'
require 'time'
require 'date'
require 'fileutils'


## our own code
require 'pixelart/version'    # note: let version always go first



module Pixelart
class Image



def self.read( path )   ## convenience helper
  img_inner = ChunkyPNG::Image.from_file( path )
  img = new( img_inner.width, img_inner.height, img_inner )
  img
end


def self.parse( pixels, colors: )
  colors = parse_colors( colors )
  pixels = parse_pixels( pixels )

  width  = pixels.reduce(1) {|width,row| row.size > width ? row.size : width }
  height = pixels.size

  img = new( width, height )

  pixels.each_with_index do |row,y|
    row.each_with_index do |color,x|
      pixel = colors[color]
      img[x,y] = pixel
    end # each row
  end # each data

  img
end



def initialize( width, height, initial=ChunkyPNG::Color::TRANSPARENT )

  if initial.is_a?( ChunkyPNG::Image )
    @img = initial
  else
    ## todo/check - initial - use parse_color here too e.g. allow "#fff" too etc.
    @img = ChunkyPNG::Image.new( width, height, initial )
  end
end



def zoom( zoom=2 )
  ## create a new zoom factor x image (2x, 3x, etc.)

  img = Image.new( @img.width*zoom,
                   @img.height*zoom )

  @img.height.times do |y|
    @img.width.times do |x|
      pixel = @img[x,y]
      zoom.times do |n|
        zoom.times do |m|
          img[n+zoom*x,m+zoom*y] = pixel
        end
      end
    end # each x
  end # each y

  img
end
alias_method :scale, :zoom




#####
# (image) delegates
##   todo/check: add some more??
def save( path, constraints = {} )
  # step 1: make sure outdir exits
  outdir = File.dirname( path )
  FileUtils.mkdir_p( outdir )  unless Dir.exist?( outdir )

  # step 2: save
  @img.save( path, constraints )
end
alias_method :write, :save


def compose!( other, x=0, y=0 )
  @img.compose!( other.image, x, y )    ## note: "unwrap" inner image ref
end
alias_method :paste!, :compose!


def width()        @img.width; end
def height()       @img.height; end

def []( x, y )          @img[x,y]; end
def []=( x, y, value )  @img[x,y]=value; end

## return image ref - use a different name - why? why not?
def image()        @img; end




######
# helpers
def self.parse_pixels( pixels )
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


def self.parse_colors( colors )
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

def self.parse_color( color )
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
