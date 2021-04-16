module Pixelart


class Color
  TRANSPARENT = 0            # rgba(  0,  0,  0,  0)
  BLACK       = 0xff         # rgba(  0,  0,  0,255)
  WHITE       = 0xffffffff   # rgba(255,255,255,255)



  def self.parse( color )
    if color.is_a?( Integer )  ## e.g. assumes ChunkyPNG::Color.rgb() or such
      color ## pass through as is 1:1
    elsif color.is_a?( Array )  ## assume array of hsl(a) e. g. [180, 0.86, 0.88]
      from_hsl( *color )
    elsif color.is_a?( String )
      if color.downcase == 'transparent'   ## special case for builtin colors
        TRANSPARENT
      else
        ## note: return an Integer !!! (not a Color class or such!!! )
        from_hex( color )
      end
    else
      raise ArgumentError, "unknown color format; cannot parse - expected rgb hex string e.g. d3d3d3"
    end
  end

  def self.from_hex( hex )
    ## Creates a color by converting it from a string in hex notation.
    ##
    ## It supports colors with (#rrggbbaa) or without (#rrggbb)
    ##  alpha channel as well as the 3-digit short format (#rgb)
    ## for those without. Color strings may include
    ## the prefix "0x" or "#"".
    ChunkyPNG::Color.from_hex( hex )
  end

  def self.from_hsl( hue, saturation, lightness, alpha=255)
    ChunkyPNG::Color.from_hsl( hue,
                               saturation,
                               lightness,
                               alpha )
  end


  def self.to_hex( color, include_alpha: true )
    ChunkyPNG::Color.to_hex( color, include_alpha )
  end

  def self.to_hsl( color, include_alpha: true )
    # Returns an array with the separate HSL components of a color.
    ChunkyPNG::Color.to_hsl( color, include_alpha )
  end

  def self.r( color ) ChunkyPNG::Color.r( color ); end
  def self.g( color ) ChunkyPNG::Color.g( color ); end
  def self.b( color ) ChunkyPNG::Color.b( color ); end

  def self.rgb( r, g, b ) ChunkyPNG::Color.rgb( r, g, b); end



  ## known built-in color names
  def self.build_names
    names = {
      '#00000000' => 'TRANSPARENT',
      '#000000ff' => 'BLACK',
      '#ffffffff' => 'WHITE',
    }

    ## auto-add grayscale 1 to 254
    (1..254).each do |n|
      hex = "#" + ('%02x' % n)*3
      hex << "ff"  ## add alpha channel (255)
      names[ hex ] = "8-BIT GRAYSCALE ##{n}"
    end

    names
  end

  NAMES = build_names



  def self.format( color )
    hex = to_hex( color )   # rgba in hex (string format)
    hsl = to_hsl( color )
    rgb = [r(color),
           g(color),
           b(color)]

    buf = ''
    buf << hex
    buf << " / "
    buf << "rgb("
    buf << "%3d " % rgb[0]
    buf << "%3d " % rgb[1]
    buf << "%3d)"  % rgb[2]
    buf << " - "
    buf << "hsla("
    buf << "%3d° " % (hsl[0] % 360)
    buf << "%3d%% " % (hsl[1]*100+0.5).to_i
    buf << "%3d%% " % (hsl[2]*100+0.5).to_i
    buf << "%3d)" % hsl[3]


    name = NAMES[ hex ]
    buf << " - #{name}"  if name

    buf
  end
  class << self
    alias_method :fmt, :format
  end

end  # class Color
end  # module Pixelart


