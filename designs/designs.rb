$LOAD_PATH.unshift( "../mooncats/lib" )
require 'mooncats'


rootdir = '../../design.mooncats'

colors = ['331a00', '663300', 'e67300', 'ffb366', 'ff9999' ]

designs = (8..11).to_a +
          (12..15).to_a

designs.each do |num|
  ['original', 'v2'].each do |series|
    puts "#{num}"

    name = '%03d' % num
    design = Mooncats::Design.read( "#{rootdir}/#{series}/#{name}.txt" )

    cat = Mooncats::Image.new( design: design, colors: colors )
    cat.save( "#{rootdir}/i/#{series}-#{name}.png" )
    cat.zoom(4).save( "#{rootdir}/i/#{series}-#{name}x4.png" )
  end
end

puts "bye"
