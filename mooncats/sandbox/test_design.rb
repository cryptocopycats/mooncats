###
#  to run use
#     ruby -I ./lib sandbox/test_design.rb


require 'mooncats'


puts "==> #{DESIGNS.size} design(s)"   #=> 128 design(s)

design =  Mooncats::Design.find( 0 )
pp design
puts design.to_txt

def dump( design )
  pp design
  puts design.to_txt
  design.each_with_index do |row, y|
   puts "#{[y]} #{row.inspect}"
  end
  puts "  #{design.width}x#{design.height}"
end



puts "---"
design = Mooncats::Design.parse( DESIGNS[0] )
dump( design )


puts "---"
design = Mooncats::Design.parse( <<TXT )
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
dump( design )


puts "==> #{DESIGNS_V2.size} design(s)"   #=> 128 design(s)


design = Mooncats::Design.parse( DESIGNS_V2[8] )
dump( design )

puts "---"
design = Mooncats::Design.parse( DESIGNS_V2[11] )
dump( design )



puts "==> #{DESIGNS_CRYPTOCATS.size} design(s)"   #=> 128 design(s)

design = Mooncats::Design.parse( DESIGNS_CRYPTOCATS[0] )
dump( design )


puts "bye"
