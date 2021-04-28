
module Mooncats


class Design
def self.find( num )   ## pass in design index number (0 to 127)
  ## todo: add cache (memoize) - why? why not?
  design = parse( DESIGNS[ num ] )

  puts "    design ##{num} (#{design.width}x#{design.height})"
  ## pp design.data
  ## puts

  design
end


def self.read( path )
  text = File.open( path, 'r:utf-8') { |f| f.read }
  parse( text )
end

def self.parse( str )
  ## support original "classic" compact single-line format
  ##   e.g. 00011111100000000.01113333310000000.13533333331110000....
  ##  note: this format needs to get rotated by 90 degree!!!
  if str.start_with?( /[0-5]+\.[0-5]+\.[0-5]+/ )  ## quick (and dirty) heuristic check
    data = str.split('.')

    ## note: map colors encoded as a string to an array of integers - why? why not?
    ##  e.g. "00011111133344411"
    ##          =>
    ##       [0,0,0,1,1,1,1,1,1,3,3,3,4,4,4,1,1]
    data = data.map do |row|
             row.chars.map do |color|
                color.to_i
             end
           end
    data = data.transpose   ## note: rotate by 90 degree!!!!!
  else  ## assume "modern" pixelart format
     ## todo/check: delegate to pixelart parse or such - why? why not?

     data = []
     str.each_line do |line|
       line = line.strip
       next if line.empty?               ## skipping empty line in pixel art source
       next if line.start_with?( '#' )   ## skipping comment line in pixel art source

       ## note: allow multiple spaces or tabs to separate pixel codes
       data << line.split( /[ \t]+/)
     end
     ## todo/check: change to use strings (instead of nummbers) in the future?
     ##                 why? why not?  stay "compatible" to pixel art format/machinery?
     data = data.map do |row|
       row.map do |color|
          color.to_i
       end
     end
  end
  new( data )
end


def initialize( data )
 @data = data
end

def width
  ## todo/check: use/find max - why? why not? lets you you used "unbalanced" / shortcut lines too
  @data[0].size
end
def height() @data.size; end


def each_with_index( &blk )
  @data.each_with_index { |row, y| blk.call( row, y ) }
end
def each( &blk )
  @data.each { |row| blk.call( row ) }
end



def to_txt
  buf = String.new('')

  @data.each do |row|
    buf << row.join( ' ' )
    buf << "\n"
  end
  buf
end
end # class Design



###############
## todo/check:
##    find a better way to (auto?) include more designs?
class DesignSeries    ## find a better name for class - why? why not?
  def self.build( dir )
    data = {}
    paths =  Dir.glob( "#{dir}/**.txt" )
    paths.each do |path|
      basename = File.basename( path, File.extname( path ) )
      num  = basename.to_i( 10 )  ## use base 10 (e.g. 001 => 1, 002 => 2, etc.)
      text = File.open( path, 'r:utf-8' ) { |f| f.read }
      ## todo/check: auto-parse "ahead of time" here
      ##              or keep "raw" text - why? why not?
      data[ num ] = text
    end
    data
  end

  def initialize( dir )
    @dir = dir  # e.g. "#{Mooncats.root}/config/v2"
  end

  def data
    ## note: lazy load / build on first demand only
    @data ||= self.class.build( @dir )
  end

  def [](index) data[ index ]; end
  def size()    data.size; end
end   # class DesignSeries
end # module Mooncats
