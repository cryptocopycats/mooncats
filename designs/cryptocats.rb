require 'mooncats'


rootdir = '../../design.mooncats'

colors = ['331a00', '663300', 'e67300', 'ffb366', 'ff9999', '000000', 'ffffff' ]

designs = [0,1,2,3]

series = 'cryptocats'
designs.each do |num|
  puts "#{num}"

  name = '%03d' % num
  design = Mooncats::Design.read( "#{rootdir}/#{series}/#{name}.txt" )

  cat = Mooncats::Image.new( design: design, colors: colors )
  cat.save( "#{rootdir}/i/#{series}-#{name}.png" )
  cat.zoom(4).save( "#{rootdir}/i/#{series}-#{name}x4.png" )
end

puts "bye"
