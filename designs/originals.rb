$LOAD_PATH.unshift( "../mooncats/lib" )
require 'mooncats'


pp DESIGNS
puts " #{DESIGNS.size} design(s)"

DESIGNS.each_with_index do |design,i|
  design = Mooncats::Design.parse( design )
  meta   = Mooncats::Metadata::Design.new( i )

  buf = ''

  buf << "##############################\n"
  buf << "# design: #{i} - #{meta.pose} #{meta.face} #{meta.fur} #{meta.facing}\n"
  buf << "# size: #{design.width}x#{design.height}\n"
  buf << "###########################\n"
  buf << "\n"
  buf << design.to_txt

  puts buf


  name = '%03d' % i
  path = "./tmp/#{name}.txt"
  puts path

  File.open( path, 'w:utf-8' ) { |f| f.write( buf ) }
end


puts "bye"
