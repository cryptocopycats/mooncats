
module Mooncats


class Image <  Pixelart::Image


COLORS_GENESIS_WHITE = ['#555555', '#d3d3d3', '#ffffff', '#aaaaaa', '#ff9999']
COLORS_GENESIS_BLACK = ['#555555', '#222222', '#111111', '#bbbbbb', '#ff9999']


def self.generate( id )
  meta = Metadata.new( id )

  design = meta.design.to_i   # note: meta.design is a struct/object - keep/use a local int !!!

  colors = if meta.genesis?
              if design % 2 == 0 && meta.invert? ||
                 design % 2 == 1 && !meta.invert?
                 COLORS_GENESIS_WHITE
              else
                 COLORS_GENESIS_BLACK
              end
           else
             derive_palette( r: meta.r,
                             g: meta.g,
                             b: meta.b,
                             invert: meta.invert? )
           end

  new( design: design,
       colors: colors )
end

### add more (convenience) aliases
class << self
  alias_method :mint, :generate
end



def initialize( design: 0,
                colors: COLORS_GENESIS_WHITE )

    design =  if design.is_a?( String )
                 Design.parse( design )
              elsif design.is_a?( Array )
                 Design.new( design )
              elsif design.is_a?( Design )
                 design  ## pass through as is 1:1
              else  ## assume integer nuber
                 design_num = design  ## note: for convenience "porcelain" param is named design (NOT design_num)
                 Design.find( design_num )
              end

    ## note: first color (index 0) is always nil (default/white or transparent)
    colors = [ nil ] + colors.map { |color| Pixelart::Color.parse( color ) }

    ## puts " colors:"
    ## pp colors

  img = ChunkyPNG::Image.new( design.width,
                              design.height,
                              ChunkyPNG::Color::TRANSPARENT ) # why? why not?

    design.each_with_index do |row, y|
      row.each_with_index do |color, x|
        if color > 0
          pixel = colors[ color ]
          img[x,y] = pixel
        end # has color?
      end # each row
    end # each data

    super( img.width, img.height, img )
end



##################
#  (static) helpers
def self.derive_palette( r: nil, g: nil, b: nil,
                         hue: nil,
                         invert: false )

   if hue
     ## pass through as is 1:1
   else ## assume r, g, b
      ## note: Color.rgb returns an Integer (e.g. 34113279 - true color or just hex rgba or?)
      rgb = ChunkyPNG::Color.rgb( r, g, b )

      # to_hsl(color, include_alpha = false) ⇒ Array<Fixnum>[0], ...
       #   Returns an array with the separate HSL components of a color.
      hsl = ChunkyPNG::Color.to_hsl( rgb )
      #=> [237, 0.9705882352941178, 0.26666666666666666]

      # h = hsl[0]
      # s = hsl[1]
      # l = hsl[2]

      hue = hsl[0]
   end

   hx = hue % 360      ## note: makes sure number is always POSITIVE (e.g. -13 % 360 => 347)
   hy = (hue + 320) % 360
  #=> e.g. hx: 237, hy: 197

  c1 = ChunkyPNG::Color.from_hsl( hx, 1, 0.1 )
  if invert
    c4 = ChunkyPNG::Color.from_hsl( hx, 1, 0.2 )
    c5 = ChunkyPNG::Color.from_hsl( hx, 1, 0.45 )
    c2 = ChunkyPNG::Color.from_hsl( hx, 1, 0.7 )
    c3 = ChunkyPNG::Color.from_hsl( hy, 1, 0.8 )
  else
    c2 = ChunkyPNG::Color.from_hsl( hx, 1, 0.2 )
    c3 = ChunkyPNG::Color.from_hsl( hx, 1, 0.45 )
    c4 = ChunkyPNG::Color.from_hsl( hx, 1, 0.7 )
    c5 = ChunkyPNG::Color.from_hsl( hy, 1, 0.8 )
  end

  ## note: returns an array of Integers!!
  ## e.g. [144127, 354047, 779775, 1701707775, 2581790719]
  [c1, c2, c3, c4, c5]
end


end # class Image
end # module Mooncats

