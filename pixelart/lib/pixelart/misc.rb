###
# misc utilities / helpers
#   move to its own files later - why? why not?

module Pixelart


class Palette8bit     # or use Palette256 alias?

  ## 8x32 gradient color stops
  ##   see https://en.wikipedia.org/wiki/List_of_software_palettes#Color_gradient_palettes

  GRAYSCALE_STOPS = [
    ## todo/fix: no need to use gradient for grayscale
    ##           it's just counting from 0 to 255!!!
    ##           e.g. rgb(0,0,0), rgb(1,1,1), rgb(2,2,2), etc.
    ['000000','1F1F1F'],
    ['202020','3F3F3F'],
    ['404040','5F5F5F'],
    ['606060','7F7F7F'],

    ['808080','9F9F9F'],
    ['A0A0A0','BFBFBF'],
    ['C0C0C0','DFDFDF'],
    ['E0E0E0','FFFFFF'],
  ]

  SEPIA_STOPS = [
    ['080400', '262117'],
    ['272218', '453E2F'],
    ['463F30', '645C48'],
    ['655D48', '837A60'],

    ['847A60', 'A29778'],
    ['A39878', 'C1B590'],
    ['C2B691', 'E0D2A8'],
    ['E1D3A9', 'FEEFBF'],
  ]

  BLUE_STOPS = [
    ['000000', '001F3E'],
    ['002040', '003F7E'],
    ['004080', '005FBD'],
    ['0060BF', '007FFD'],

    ['0080FF', '009FFF'],
    ['00A0FF', '00BFFF'],
    ['00C0FF', '00DFFF'],
    ['00E0FF', '00FEFF'],
  ]

  FALSE_STOPS = [
    ['FF00FF', '6400FF'],
    ['5F00FF', '003CFF'],
    ['0041FF', '00DCFF'],
    ['00E1FF', '00FF82'],

    ['00FF7D', '1EFF00'],
    ['23FF00', 'BEFF00'],
    ['C3FF00', 'FFA000'],
    ['FF9B00', 'FF0000'],
  ]



  def self.build_palette( palette )
    ## todo/check: assert assume 8 color stop definitions (8x32=256)
    colors = []
    palette.each do |stops|
      colors += Gradient.new( stops[0], stops[1] ).colors( 32 )
    end
    colors
  end


  GRAYSCALE = build_palette( GRAYSCALE_STOPS )
  SEPIA     = build_palette( SEPIA_STOPS )
  BLUE      = build_palette( BLUE_STOPS )
  FALSE     = build_palette( FALSE_STOPS )
end  # class Palette8bit

#####################
# add aliases
Palette8Bit = Palette8bit
Palette256  = Palette8bit



class Image
class Palette8bit < Image  # or use Palette256 alias?
  def initialize( colors, size: 1, spacing: nil )
    ## todo/check: change size arg to pixel or such? better name/less confusing - why? why not?

    ## todo/check: assert colors MUST have 256 colors!!!!

    ## use a "smart" default if no spacing set
    ##   0 for for (pixel) size == 1
    ##   1 for the rest
    spacing = size == 1 ? 0 : 1  if spacing.nil?

    img = ChunkyPNG::Image.new( 32*size+(32-1)*spacing,
                                 8*size+(8-1)*spacing )

    colors.each_with_index do |color,i|
      y,x = i.divmod( 32 )
      if size > 1
        size.times do |n|
          size.times do |m|
            img[ x*size+n+spacing*x,
                 y*size+m+spacing*y] = color
          end
        end
      else
        img[x,y] = color
      end
    end

    super( img.width, img.height, img )
  end
end # class Palette8bit

#####################
# add aliases
Palette8Bit = Palette8bit
Palette256  = Palette8bit

end # class Image

end # module Pixelart

