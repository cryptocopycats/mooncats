###
#  to run use
#     ruby -I ./lib sandbox/test_gradient.rb


require 'pixelart'


gradient = Pixelart::Gradient.new( '000000', 'ffffff' )

pp colors = gradient.colors( 256 )   ## 256 steps
puts "---"
pp colors.map { |color| Pixelart::Color.to_hex( color ) }

puts "---"
pp colors = gradient.colors( 10 )    ## 10 steps


puts "bye"
