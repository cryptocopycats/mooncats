#####
# to run use:
#   $ ruby ./led.rb


require 'mooncats'


ids = ['0077c8278d', '00000800fa']
ids.each do |id|
  cat = Mooncats::Image.mint( id )
  puts " #{cat.width}x#{cat.height}"
  cat.save( "./i/mooncat-#{id}.png" )

  cat_led = cat.led( 8, spacing: 2 )
  cat_led.save( "./i/mooncat-#{id}_led8x.png" )

  cat_led = cat.led( 16, spacing: 3 )
  cat_led.save( "./i/mooncat-#{id}_led16x.png" )

  cat_led = cat.led( 16, spacing: 8, round_corner: true )
  cat_led.save( "./i/mooncat-#{id}_led16xr.png" )
end


puts "bye"

