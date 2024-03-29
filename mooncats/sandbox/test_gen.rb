###
#  to run use
#     ruby -I ./lib sandbox/test_gen.rb


require 'mooncats'

puts " #{DESIGNS.size} design(s)"   #=> 128 design(s)



colors = ['555555', 'd3d3d3', 'ffffff', 'aaaaaa', 'ff9999' ]

cat = Mooncats::Image.new( design: 0, colors: colors )
cat.save( './tmp/design-000.png' )

colors = ['555555', '222222', '111111', 'bbbbbb', 'ff9999']

cat = Mooncats::Image.new( design: 3, colors: colors )
cat.zoom(3).save( './tmp/design-003x2.png' )

cat = Mooncats::Image.new( design: DESIGNS[4], colors: colors )
cat.zoom(2).save( './tmp/design-004x2.png' )

cat = Mooncats::Image.new( design: Mooncats::Design.find( 5 ),
                           colors: colors )
cat.zoom(2).save( './tmp/design-005x2.png' )


cat = Mooncats::Image.new( design: <<TXT, colors: colors )
##############################
# design: 0 - Standing Smiling Pure Left
# size: 21x17
###########################

0 0 1 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0
0 1 3 1 0 0 0 1 3 1 0 0 0 0 0 0 0 0 0 0 0
0 1 5 3 1 1 1 3 5 1 0 0 0 0 0 0 0 0 0 0 0
1 1 3 3 3 3 3 3 3 1 1 0 0 0 0 0 0 1 1 1 0
1 3 3 3 3 3 3 3 3 3 1 0 0 0 0 0 0 1 3 1 0
1 3 3 1 3 3 3 1 3 3 1 1 1 1 1 1 0 1 1 3 1
1 3 3 3 3 3 3 3 3 3 1 3 3 3 3 1 1 0 1 3 1
1 3 3 4 3 5 3 4 3 3 1 3 3 3 3 3 1 0 1 3 1
1 3 3 3 4 3 4 3 3 3 1 3 3 3 3 3 1 1 1 3 1
0 1 3 3 3 3 3 3 3 1 3 3 3 3 3 3 3 3 3 1 1
0 0 1 1 1 1 1 1 1 3 3 3 3 3 3 3 3 1 1 1 0
0 0 1 3 3 3 3 3 3 3 3 3 3 3 3 3 3 1 0 0 0
0 0 1 3 3 3 3 3 1 4 4 4 1 3 3 3 1 1 0 0 0
0 0 0 1 3 3 1 3 3 1 4 1 3 3 3 1 1 0 0 0 0
0 0 0 0 1 3 1 1 3 1 4 1 3 3 1 1 0 0 0 0 0
0 0 0 0 1 5 1 1 5 1 1 5 3 1 1 0 0 0 0 0 0
0 0 0 0 1 1 1 1 1 1 1 1 1 1 0 0 0 0 0 0 0
TXT
cat.zoom(2).save( './tmp/design-000x2.png' )


puts "bye"
