$LOAD_PATH.unshift( "../../cryptocopycats/mooncats/mooncats/lib" )
require 'mooncats'



def parse_design( design )
  data = design.split('.')
  data = data.map do |row|
           row.chars.map do |color|
              color.to_i
           end
         end
  ## pp data
  ## puts "---"
  data.transpose   ## rotate by 90 degree
end


def design_to_txt( design )
  buf = String.new('')

  design.each do |row|
    buf << row.join( ' ' )
    buf << "\n"
  end
  buf
end




pp DESIGNS
puts " #{DESIGNS.size} design(s)"

DESIGNS.each_with_index do |design,i|
  design = parse_design( design )

  width = design[0].size
  height = design.size

  meta = Mooncats::Metadata::Design.new( i )

  buf = ''

  buf << "##############################\n"
  buf << "# design: #{i} - #{meta.pose} #{meta.face} #{meta.fur} #{meta.facing}\n"
  buf << "# size: #{width}x#{height}\n"
  buf << "###########################\n"
  buf << "\n"
  buf << design_to_txt( design )

  puts buf


  name = '%03d' % i
  path = "../../cryptocopycats/design.mooncats/original/#{name}.txt"
  puts path

  File.open( path, 'w:utf-8' ) { |f| f.write( buf ) }
end


puts "bye"