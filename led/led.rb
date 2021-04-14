require 'mooncats'


ids = ['0077c8278d', '00000800fa']
ids.each do |id|
  Mooncats::Image.mint( id ).save( "./i/mooncat-#{id}.png" )
end



require 'pixelart'


module Pixelart
class Color
  TRANSPARENT = 0            # rgba(  0,  0,  0,  0)
  BLACK       = 0xff         # rgba(  0,  0,  0,255)
  WHITE       = 0xffffffff   # rgba(255,255,255,255)
end

class Image
  def led( led=8, spacing: 2, round_corner: false )

    width  = @img.width*led  + (@img.width-1)*spacing
    height = @img.height*led + (@img.height-1)*spacing

    puts " #{@img.width}x#{@img.height} => #{width}x#{height}"

    img = Image.new( width, height, Color::BLACK )

    @img.width.times do |x|
      @img.height.times do |y|
        pixel = @img[x,y]
        pixel = Color::BLACK  if pixel == Color::WHITE
        led.times do |n|
          led.times do |m|
            ## round a little - drop all four corners for now
            next  if round_corner &&
                    [[0,0],[0,1],[1,0],[1,1],[0,2],[2,0],
                     [0,led-1],[0,led-2],[1,led-1],[1,led-2],[0,led-3],[2,led-1],
                     [led-1,0],[led-1,1],[led-2,0],[led-2,1],[led-1,2],[led-3,0],
                     [led-1,led-1],[led-1,led-2],[led-2,led-1],[led-2,led-2],[led-1,led-3],[led-3,led-1],
                    ].include?( [n,m] )
            img[x*led+n + spacing*x,
                y*led+m + spacing*y] = pixel
          end
        end
      end
    end
    img
  end
end # class Image
end # module Pixelart




ids.each do |id|
  cat = Pixelart::Image.read( "./i/mooncat-#{id}.png" )
  puts " #{cat.width}x#{cat.height}"

  cat_led = cat.led( 8, spacing: 2 )
  cat_led.save( "./i/mooncat-#{id}_led8x.png" )

  cat_led = cat.led( 16, spacing: 3 )
  cat_led.save( "./i/mooncat-#{id}_led16x.png" )

  cat_led = cat.led( 16, spacing: 8, round_corner: true )
  cat_led.save( "./i/mooncat-#{id}_led16xr.png" )
end


puts "bye"


