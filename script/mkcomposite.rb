###
#  to run use
#     ruby -I ./lib script/mkcomposite.rb


require 'mooncats'


## read metadata (5-byte hexstring ids, etc.)
data = Mooncats::Dataset.read( '../mooncatrescue/*.csv' )

puts "  #{data.size} mooncat(s)"
#=> 25440 mooncat(s)



MOONCATS_COLS = 100
MOONCATS_ROWS = 255

CANVAS_WIDTH  = 24
CANVAS_HEIGHT = 24

composite = ChunkyPNG::Image.new( MOONCATS_COLS*CANVAS_WIDTH,
                                  MOONCATS_ROWS*CANVAS_HEIGHT,
                                  ChunkyPNG::Color::WHITE ) # why? why not?

i=0
MOONCATS_ROWS.times do |y|
  MOONCATS_COLS.times do |x|
    puts "  adding #{i} - x:#{x}/y:#{y}..."
    cat_meta = data[i]
    if cat_meta
      cat_id = cat_meta['id']
      cat = Mooncats::Image.generate( cat_id )
      puts "    width: #{cat.width}, height: #{cat.height}"

      ## try to center image (identicon) in 24x24 canvas
      ##   the 4 formats are
      ##   - 21×17 - Standing
      ##   - 20×14 - Sleeping
      ##   - 17×22 - Pouncing
      ##   - 20×21 - Stalking
      x_center = case cat.width
                 when 17 then 3   ## e.g. for (17×_) add 3 more pixel left padding
                 when 20 then 2   ##      for (20×_) add 2 more
                 when 21 then 1   ##      for (21×_) add 1 more
                 end

      y_center = case cat.height
                 when 14 then 5   ## e.g. for (_×14) add 5 more pixel top padding
                 when 17 then 3   ##      for (_×17) add 3
                 when 21 then 1   ##      for (_×21) add 1
                 when 22 then 1   ##      for (_×22) add 1
                 end

      composite.compose!( cat.image, x*CANVAS_WIDTH+x_center, y*CANVAS_HEIGHT+y_center )
    else
      puts "!! WARN - no cat meta info found; skipping"
    end
    i += 1
  end
  puts
end


composite.save( 'tmp/mooncatrescue.png', :best_compression )

puts "bye"
