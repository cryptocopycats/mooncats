###
#  to run use
#     ruby ./spots.rb


require 'pixelart'



img = Image.new( 24, 24 )
# 20x21  - place in 24x24 canvas
#  add x-offset +2, y-offset +1
img.compose!( Image.read( './i/mooncat-0077c8278d.png' ), 2, 1 )

img_spots = img.spots( 10 )
img_spots.save( './i/spots-0077c8278d.png' )

img_spots = img.zoom(2).spots( 5, spacing: 5,
                            center: [-1,1], radius: [3,6] )
img_spots.save( './i/spots-0077c8278d@2x.png' )



BACKGROUND_SPOTS = [
 # blue-ish
 '49355E', '16437A', '096598', '4B8BBB', '9CD9DE', 'C5A7C6',
 # red-ish
 'A5282C', 'D14C37', 'CF6A71', 'DD5E36', 'DDA315', 'F3A925',
 # green-ish
 '4C7031', '95A025', '66BA8C', '316D5F',
 # gray-ish /white-ish
 'C2B6AF', 'BFC0C5', '3BC8B5',
]



img.zoom(2).spots( 5, spacing: 5,
                      center: [-1,1], radius: [3,6],
                      background: BACKGROUND_SPOTS ).save( './i/currency-v1-0077c8278d@2x.png' )

img.zoom(2).spots( 5, spacing: 5,
                      center: [-3,3], radius: [2,8],
                      background: BACKGROUND_SPOTS ).save( './i/currency-v2-0077c8278d@2x.png' )

img.zoom(2).spots_hidef( 5, spacing: 5,
                            center: [-3,3], radius: [2,8],
                            background: BACKGROUND_SPOTS ).save( './i/currency-v2-0077c8278d@2x.svg' )



puts "bye"
