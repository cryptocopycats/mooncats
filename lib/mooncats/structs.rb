
module Mooncats

### wrap metadata (e.g. pose, fur, facing, color, etc.)
##     in structs for easy/easier access)

POSES = [
  'Standing',  ## 00
  'Sleeping',  ## 01
  'Pouncing',  ## 10
  'Stalking',  ## 11
]

FACES = [
  'Smile',              ## 00
  'Frown (Look Down)',  ## 01
  'Frown (Look Up)',    ## 10
  'Flat Whiskers',      ## 11
]

FURS = [
  'Solid',      ## 00
  'Striped',    ## 01
  'Eyepatch',   ## 10
  'Half/Half',  ## 11
]

FACINGS = [
  'Left',   # 0
  'Right',  # 1
]



class Metadata

  class Design ## nested classed  - why? lets you use Metadata::Design "standalone", that is, without 5-byte id
    def initialize( num )   # 0-127 design num(ber)
      @num = num
    end

    def to_i() @num; end

    def bits  ## keep private / internal - why? why not?
      ## keep 128 possible designs 0 to 127
      ##   as 7 bit string e.g. 01010111  for now - why? why not?
      @bits ||= '%08b' % @num
    end

    def facing
      @facing ||= FACINGS[ bits[1,1].to_i(2) ]  ## use desgin > 63 instead  - why? why not?
    end
    def face
      @face ||= FACES[ bits[2,2].to_i(2) ]
    end
    def fur
      @fur ||= FURS[ bits[4,2].to_i(2) ]
    end
    def pose
      @poses ||= POSES[ bits[6,2].to_i(2) ]   ##  use design % 4 instead - why? why not?
    end
  end  ## (nested) class Metadata::Design




  def initialize( id, **more )
    @bytes = self.class.hex_to_bytes( id )

    ## add support for more "external" meta data
    ##   ## e.g. mint, mint_block, etc.
    @more = more
  end

  def id
    @id ||= @bytes.map { |byte| '%02x' % byte }.join
  end

  def genesis?
    @bytes[0] != 0   ## note: convert to bool (if zero assume NOT genesis)
  end
  def k() @bytes[1]; end
  def r() @bytes[2]; end
  def g() @bytes[3]; end
  def b() @bytes[4]; end

  def rgb() [r,g,b]; end   ## add rgb shortcut helper - why? why not?

  def invert?() k >= 128; end
  def pattern() k % 64; end   ## treat facing left|right as the same


  def hue
    @hue ||= begin
       ## note: hsl[0], that is, hue MIGHT BE NEGATIVE!
       ##   e.g. try rbg( 91, 27, 41 )
       ##         resulting in
       ##          hsl( -13, 0.5423728813559322, 0.23137254901960785 )
       ##  remember: always use % 360 to make positive!!!
       ##    e.g.   -13 % 360   => 347
       ##           -25 % 360   => 335
               rgb = ChunkyPNG::Color.rgb( r, g, b )
               hsl = ChunkyPNG::Color.to_hsl( rgb )
               hsl[0] % 360    ## make sure number is always POSITIVE!!!
             end
  end


  def color
    case hue
    when 345..359,
           0..14   then 'Red'
    when  15..44   then 'Orange'
    when  45..74   then 'Yellow'
    when  75..104  then 'Chartreuse'
    when 105..134  then 'Green'
    when 135..164  then 'Teal'
    when 165..194  then 'Cyan'
    when 195..224  then 'Sky Blue'
    when 225..254  then 'Blue'
    when 255..284  then 'Purple'
    when 285..314  then 'Magenta'
    when 315..344  then 'Fuchsia'
    else
      puts "!! ERROR - unexpected hue (in degress); got #{hue} - expected 0 to 359"
      exit 1
    end
 end


  def xxx_color_old_formula   ## remove - move to attic??
    case hue
    when   0..29  then 'Red'
    when  30..59  then 'Orange'
    when  60..89  then 'Yellow'
    when  90..119 then 'Chartreuse'
    when 120..149 then 'Green'
    when 150..179 then 'Lime Green'    ## now renamed to Teal
    when 180..209 then 'Cyan'
    when 210..239 then 'Sky Blue'
    when 240..269 then 'Blue'
    when 270..299 then 'Purple'
    when 300..329 then 'Magenta'
    when 330..359 then 'Fuchsia'
    else
     puts "!! ERROR - unexpected hue (in degress); got #{hue} - expected 0 to 359"
     exit 1
    end
  end


  def design
    @design ||= Design.new( k % 128 )
  end

  def facing()  design.facing; end
  def face()    design.face; end
  def fur()     design.fur; end
  def pose()    design.pose; end


  ####
  # more "external" attributes
  def mint()      @more[:mint]; end
  def block()     @more[:block]; end
  def timestamp() @more[:timestamp]; end
  def year()      timestamp ? timestamp.year : nil; end

  #####
  # enable array-like access to - why? why not?
  def []( key )
     case key.to_sym
     when :id      then id
     when :genesis then genesis?
     when :k       then k
     when :r       then r
     when :g       then g
     when :b       then b
     when :rgb     then rgb
     when :invert  then invert?
     when :hue     then hue
     when :color   then color
     when :design  then design.to_i
     when :pattern then pattern
     when :facing  then facing
     when :face    then face
     when :fur     then fur
     when :pose    then pose
     when :year    then year    # note: from more via timestamp
     else
       @more[ key ]
     end
  end


  ##################
  #  (static) helpers
  def self.hex_to_bytes( str_or_num )
    if str_or_num.is_a?( Integer )  ## allow passing in of integer to e.g. 0x... etc.
       num = str_or_num
       str = '%010x' % num    # 5 bytes (10 hex digits/chars)
    else ## assume string
       ## cut-off optionial 0x
       str = str_or_num
       str = str.downcase
       str = str[2..-1]  if str.start_with?( '0x')
    end

    raise ArgumentError, "expected 5 byte hex string (10 digits/chars); got #{str_or_num}"   if str.size != 10

    bytes = [str].pack('H*').bytes
    bytes
  end
end # class Metadata

end  # module Mooncats
