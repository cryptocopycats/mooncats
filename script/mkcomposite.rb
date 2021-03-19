###
#  to run use
#     ruby -I ./lib script/mkcomposite.rb

require 'mooncats'


## use composite image (convenience) helper / wrapper
##   note: defaults to col=100, rows=255  (100x255 = 25500 mooncats max.)
composite = Mooncats::Image::Composite.new


## read metadata (5-byte hexstring ids, etc.)
data = Mooncats::Dataset.read( '../mooncatrescue/*.csv' )

puts "  #{data.size} mooncat(s)"
#=> 25440 mooncat(s)



###
## to sort the data for example by pose, facing, face, fur in that order
##   use:
## data = data.sort do |l,r|
##                    res = l.pose   <=> r.pose                 # 1. sort by pose
##                    res = l.facing <=> r.facing  if res == 0  # 2. sort by facing if pose is equal (0)
##                    res = l.face   <=> r.face    if res == 0  # 3. sort by face if facing is equal (0) too
##                    res = l.fur    <=> r.fur     if res == 0  # 4. sort by fur if face is equal (0) too
##                    res
##                 end


data.each_with_index do |cat_meta,i|
  cat_id = cat_meta['id']

  puts "  adding [#{i}] - #{cat_id}..."

  composite << Mooncats::Image.generate( cat_id )
end


composite.save( 'tmp/mooncatrescue.png', :best_compression )

puts "bye"
