###
#  to run use
#     ruby -I ./lib sandbox/test_derive.rb

require 'mooncats'


puts 'white:'
pp ChunkyPNG::Color::WHITE
puts

r, g, b = 2, 8, 134
colors = Mooncats::Image.derive_palette( r, g, b )
pp colors
# [144127, 354047, 779775, 1701707775, 2581790719]
colors = Mooncats::Image.derive_palette( r, g, b, invert: true )
pp colors
# [144127, 1701707775, 2581790719, 354047, 779775]


cat = Mooncats::Image.generate( '0x00bece30ee' )
cat.save( './tmp/mooncat-00bece30ee.png' )

cat = Mooncats::Image.generate( '0x00bece30ee', zoom: 3 )
puts " #{cat.width} x #{cat.height}"
cat.save( './tmp/mooncat-00bece30ee_x3.png' )

cat = Mooncats::Image.generate( '0x00c719fa46' )
cat.save( './tmp/mooncat-00c719fa46.png' )


puts "bye"