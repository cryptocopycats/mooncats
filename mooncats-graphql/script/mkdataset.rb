####
# use:
#  $ ruby  script/mkdataset.rb


$LOAD_PATH.unshift( "../mooncats/lib" )
require 'mooncats'



data = []
datasets = Dir.glob( "./dl/*.json" )
pp datasets

datasets.each do |dataset|
  text = File.open( dataset, 'r:utf-8') { |f| f.read }
  data += JSON.parse( text )
end

puts "  #{data.size} record(s)"  #=>   25440 record(s)




last_id_num = 0

batches = []
batches << []


puts " processing records..."
data.each_with_index do |h,i|
   id = h['id']
   id_num = Integer( id )

   ## puts "[#{i}] #{id}"

   if last_id_num > id_num
    puts "!! ERROR - out of order - not sorted!!"
    pp h
    exit 1
   end

   last_id_num = id_num

   print "."  if i % 100 == 0

   rows = batches[-1]

   if rows.size >= 1000
    ## start a new batch
    rows = []
    batches << rows
   end

   meta = Mooncats::Metadata.new( id )

   facing = meta.design.facing
   face   = meta.design.face
   fur    = meta.design.fur
   pose   = meta.design.pose


   palette = meta.invert? ?  'Inverted' : 'Normal'


   ## keep design 0-127 possibilites?
   ##  e.g. 4*4*4*2 = 128
   ##     2 (facing) x
   ##     4 (face) x
   ##     4 (fur) x
   ##     4 (pose)
   design = meta.design.to_i

   ### change to pattern (0-63) - why? why not?
   ##    left and right facing is treated the same
   pattern = meta.pattern


   ## note: hue NOT used for genesis cats
   hue =    if meta.genesis?
                '-'
            else
               '%d°' % meta.hue   ## note: add degree (°)
            end

   ## note:
   ##  special case for genesis cats
   ##   if design is odd (0) than use black
   ##              if even (1) than use white
   color = if meta.genesis?
              design % 2 == 0 ? 'Black' : 'White'
           else
              meta.color
           end

   ## add some more non-id-derived blockchain data
   mint  = h['rescueIndex']
   block = h['rescueBlock']
   timestamp = Time.at( h['rescueTime'].to_i ).utc.to_s  ## note: convert to string

   rows << [ i, id, palette, design, pose, facing, face, fur, color, hue, mint, timestamp, block ]
end

puts "  #{batches.size} batch(es)"



## save batches
columns = [ 'row', 'id', 'palette', 'design', 'pose', 'facing', 'face', 'fur', 'color', 'hue', 'mint', 'timestamp', 'block' ]

batches.each_with_index do |batch,i|
  blk = '%02d' % i

  puts "#{blk} - #{batch[0][1]}-#{batch[-1][1]} - #{batch.size} record(s)"

  path = "./o/#{blk}.csv"
  File.open( path, 'w:utf-8') do |f|
     f.write( columns.join( ', ' ))
     f.write( "\n")

     batch.each do |values|
      f.write( values.join( ', ' ))
      f.write( "\n")
     end
  end
end

puts "bye"


## printing:
##  00 - 0x0000020886-0x000a05b9ac - 1000 record(s)
##  01 - 0x000a0a11c8-0x0013b68a2f - 1000 record(s)
##  02 - 0x0013b72770-0x001e26e929 - 1000 record(s)
##  03 - 0x001e26eec8-0x00286c7713 - 1000 record(s)
##  04 - 0x00286edc39-0x0031e3c78b - 1000 record(s)
##  05 - 0x0031e61d26-0x003b650a57 - 1000 record(s)
##  06 - 0x003b683f72-0x004504970d - 1000 record(s)
##  07 - 0x0045058738-0x004fc11191 - 1000 record(s)
##  08 - 0x004fc21270-0x0059e4f057 - 1000 record(s)
##  09 - 0x0059e5eba3-0x0063ac5c30 - 1000 record(s)
##  10 - 0x0063b17eb9-0x006e094d09 - 1000 record(s)
##  11 - 0x006e0b6a0f-0x0077b731ca - 1000 record(s)
##  12 - 0x0077bf0206-0x00813ecf63 - 1000 record(s)
##  13 - 0x0081438cf0-0x008b9e0d39 - 1000 record(s)
##  14 - 0x008ba297e2-0x0095e16fad - 1000 record(s)
##  15 - 0x0095e43a64-0x00a05887b1 - 1000 record(s)
##  16 - 0x00a05b6bbb-0x00aa610395 - 1000 record(s)
##  17 - 0x00aa6334d5-0x00b4311352 - 1000 record(s)
##  18 - 0x00b4349caa-0x00bec9ab81 - 1000 record(s)
##  19 - 0x00becd9e65-0x00c8e2dec6 - 1000 record(s)
##  20 - 0x00c8e3440f-0x00d2da441a - 1000 record(s)
##  21 - 0x00d2db81fc-0x00de20c13f - 1000 record(s)
##  22 - 0x00de2353fe-0x00e899f11f - 1000 record(s)
##  23 - 0x00e8a04cba-0x00f2e3aa1b - 1000 record(s)
##  24 - 0x00f2e62588-0x00fcbc9a6d - 1000 record(s)
##  25 - 0x00fcbd430b-0xff5f000ca7 - 440 record(s)



