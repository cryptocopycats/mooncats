###
#  to run use
#     ruby -I ./lib sandbox/test_dataset.rb

require 'mooncats'


meta = Mooncats::Metadata.new( '0x0000020886' )
puts "id >#{meta.id}<"
puts "  pose: #{meta.pose}"
puts "  facing: #{meta.facing}"
puts "  face: #{meta.face}"
puts "  fur: #{meta.fur}"

pp meta[:id]
pp meta[:facing]
pp meta[:k]
pp meta[:mint]

pp meta['id']
pp meta['facing']
pp meta['k']
pp meta['mint']

pp meta


mooncats = Mooncats::Dataset.read( '../mooncatrescue/*.csv' )

puts "  #{mooncats.size}  mooncat(s)"
#=> 25440 mooncat(s)


pp mooncats[0]
pp mooncats[-1]


puts "bye"