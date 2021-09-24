###
#  to run use
#     ruby ./spots.rb


require 'pixelart'



img = Pixelart::Image.new( 24, 24 )
# 20x21  - place in 24x24 canvas
#  add x-offset +2, y-offset +1
img.compose!( Pixelart::Image.read( './i/mooncat-0077c8278d.png' ), 2, 1 )

img_spots = img.spots( 10 )
img_spots.save( './i/spots-0077c8278d.png' )

img_spots = img.zoom(2).spots( 5, spacing: 5,
                            center: [-1,1], radius: [3,6] )
img_spots.save( './i/spots-0077c8278d@2x.png' )


puts "bye"