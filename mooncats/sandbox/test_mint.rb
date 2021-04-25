###
#  to run use
#     ruby -I ./lib sandbox/test_mint.rb


require 'mooncats'

cat = Mooncats::Image.mint( '0x00000800fa' )
cat.save( './tmp/mooncat-00000800fa.png' )

cat.zoom( 4 ).save( './tmp/mooncat-00000800fa_x4.png' )

