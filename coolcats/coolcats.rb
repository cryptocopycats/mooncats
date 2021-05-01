require 'mooncats'



## (standard/default) colors from the original online mooncat pixel drawing tool
##    see https://mooncatrescue.com/pixeleditor
colors = ['331a00', '663300', 'e67300', 'ffb366', 'ff9999' ]

designs = [0,1,2,3]
designs.each do |design|
  cat = Mooncats::Image.new( design: design, colors: colors )

  name = '%03d' % design
  cat.save( "./i/mooncat-#{name}.png" )
  cat.zoom(4).save( "./i/mooncat-#{name}x4.png" )
end






shades1 = Image.parse( <<TXT, colors: ['000000'] )
1 1 1 1 1 1 1 1 1 1 1 1
0 0 1 1 1 1 0 1 1 1 1 0
0 0 0 1 1 0 0 0 1 1 0 0
TXT
puts "  shades1 (#{shades1.width}x#{shades1.height})"

shades1.save( './i/shades1.png' )
shades1.zoom(4).save( './i/shades1x4.png' )


shades2 = Image.parse( <<TXT, colors: ['000000', '690C45', '8C0D5B', 'AD2160'] )
0 1 1 1 1 1 0 1 1 1 1 1
0 1 2 2 2 1 1 1 2 2 2 1
1 1 3 3 3 1 0 1 3 3 3 1
0 1 4 4 4 1 0 1 4 4 4 1
0 0 1 1 1 0 0 0 1 1 1 0
TXT
puts "  shades2 (#{shades2.width}x#{shades2.height})"

shades2.save( './i/shades2.png' )
shades2.zoom(4).save( './i/shades2x4.png' )


shades3 = Image.parse( <<TXT, colors: ['000000', '990033', 'FF0066', 'FF3366'] )
1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
0 1 1 2 2 2 2 1 2 2 2 2 1 1 0
0 0 1 3 3 3 3 1 3 3 3 3 1 0 0
0 0 1 4 4 1 1 1 1 1 4 4 1 0 0
0 0 1 1 1 1 0 0 0 1 1 1 1 0 0
TXT
puts "  shades3 (#{shades3.width}x#{shades3.height})"

shades3.save( './i/shades3.png' )
shades3.zoom(4).save( './i/shades3x4.png' )


shades4 = Image.parse( <<TXT, colors: ['000000', '000766', '0010e6'] )
1 1 1 1 1 1 1 1 1 1 1 1
0 0 1 2 2 1 0 1 2 2 1 0
0 0 1 3 3 1 0 1 3 3 1 0
0 0 0 1 1 0 0 0 1 1 0 0
TXT
puts "  shades4 (#{shades4.width}x#{shades4.height})"

shades4.save( './i/shades4.png' )
shades4.zoom(4).save( './i/shades4x4.png' )



head_offsets = [
  [0,3],  # pose - standing (21×17)
  [1,3],  # pose - sleeping (20×14)
  [1,3],  # pose - pouncing (17×22)
  [0,9],  # pose - stalking (20×21)
]

head_shades = [
  { image: shades1, offset: [-1,+2] },  # (12x3)
  { image: shades2, offset: [-1,+1] },  # (12x5)
  { image: shades3, offset: [-2, 0] },  # (15x5)
  { image: shades4, offset: [-1,+2] },  # (12x4)
]


head_shades.each_with_index.each do |shades, i|
   designs.each do |design|

     cat = Mooncats::Image.new( design: design, colors: colors )

     head_x,   head_y   = head_offsets[ design % 4 ]
     offset_x, offset_y = shades[:offset]

     cat.compose!( shades[:image], head_x+offset_x,
                                   head_y+offset_y )

     name = '%03d' % design
     cat.save( "./i/coolcat-#{name}_#{i+1}.png" )
     cat.zoom(4).save( "./i/coolcat-#{name}_#{i+1}x4.png" )
  end
end



puts "bye"