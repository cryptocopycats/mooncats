###
#  to run use
#     ruby -I ./lib script/mkdesigns.rb

require 'mooncats'


#################
## make designs page


buf = String.new('')

buf << "# MoonCat Designs (128)\n\n"

buf << "In original pixel size¹ and 3x zoom; tagged with pose (4), face (4), fur (4), facing (2) attributes."
buf << "\n\n\n"
buf << "¹: Standing (21×17), sleeping (20×14), pouncing (17×22), stalking (20×21)"
buf << "\n\n\n"

buf << "| Standing | Sleeping | Pouncing | Stalking |\n"
buf << "|----------|----------|----------|----------|\n"


(0..127).each_slice(4) do |slice|
  ## pp slice

   buf << "| "
   slice.each do |num|
      design = Mooncats::Metadata::Design.new( num )

      name = "design-%03d" % num

      buf << " ![](i/#{name}.png)"
      buf << " ![](i/#{name}x3.png)"
      buf << " <br> #{num} "
      buf << "#{design.pose}·"
      buf << "#{design.face}·"
      buf << "#{design.fur}·"
      buf << "#{design.facing} "
      buf << "|"
   end
   buf << "\n"
end



puts buf

File.open( './tmp/DESIGNS.md', 'w:utf-8') { |f| f.write( buf ) }

puts "bye"
