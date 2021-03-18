
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
    def initialize( design )   # 0-127 design num(ber)
      @design = design
    end

    def design_bits  ## keep private / internal - why? why not?
      ## keep 128 possible designs 0 to 127
      ##   as 7 bit string e.g. 01010111  for now - why? why not?
      @design_bits ||= '%08b' % @design
    end

    def facing
      @facing ||= FACINGS[ design_bits[1,1].to_i(2) ]  ## use desgin > 63 instead  - why? why not?
    end
    def face
      @face ||= FACES[ design_bits[2,2].to_i(2) ]
    end
    def fur
      @fur ||= FURS[ design_bits[4,2].to_i(2) ]
    end
    def pose
      @poses ||= POSES[ design_bits[6,2].to_i(2) ]   ##  use design % 4 instead - why? why not?
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


  def invert?() k >= 128; end
  def design()  k % 128; end
  def pattern() k % 64; end   ## treat facing left|right as the same


  def design_meta
    @design_meta ||= Design.new( design )
  end

  def facing()  @design_meta.facing; end
  def face()    @design_meta.face; end
  def fur()     @design_meta.fur; end
  def pose()    @design_meta.pose; end


  ####
  # more "external" attributes
  def mint()   @more[:mint]; end

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
     when :invert  then invert?
     when :design  then design
     when :pattern then pattern
     when :facing  then facing
     when :face    then face
     when :fur     then fur
     when :pose    then pose
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
