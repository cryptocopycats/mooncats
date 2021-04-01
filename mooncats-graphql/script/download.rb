####
# use:
#  $ ruby -I ./lib script/download.rb


require 'mooncats/graphql'



c = Mooncats::GraphQL::Client.new


# ~26 000 mooncats - download in 26 batches of 1000 each
last_id = '0x0000000000'

26.times do |i|
puts "downloading batch #{i}..."

  data = c.query_cats( last_id: last_id,
                        includes: [:maxAdoptionPrice] )

  name = "cats_%02d" % i
  puts "  #{name} - #{data.size} record(s)"

  File.open( "./dl/#{name}.json", 'w:utf-8' ) do |f|
    f.write( JSON.pretty_generate( data ))
  end

  last_id = data[-1]['id']
  puts "  last_id: #{last_id}"
  sleep( 1 )
end



puts "bye"