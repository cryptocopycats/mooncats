####
# use:
#  $ ruby -I ./lib sandbox/test_query.rb


require 'mooncats/graphql'



c = Mooncats::GraphQL::Client.new



data = c.query_bestsellers( first: 12 )
pp data
puts "---"
sleep( 1 )


WEI_PER_ETHER  = 1000000000000000000
data.each_with_index do |rec,i|
  print '%2d.  ' % (i+1)
  print '%3d ETH' % (rec['maxAdoptionPrice'].to_i / WEI_PER_ETHER)
  print ' - '
  print rec['id']
  print "\n"
end



data = c.query_cats( first: 10, includes: [:maxAdoptionPrice, :isGenesis] )
pp data
puts "---"
sleep( 1 )

data = c.query_cats( first: 5, last_id: data[-1]['id'] )
pp data
puts "---"
sleep( 1 )


data = c.query_mint_2017( first: 10 )
pp data
puts "---"
sleep( 1 )

data = c.query_cat_by_id( id: '0xff52000ca7' )
pp data
puts "---"
sleep( 1 )


data = c.query_cat_by_wrapper_id( id: 0 )
pp data
puts "---"
sleep( 1 )

data = c.query_cheap_mints_2017
pp data
puts "---"
sleep( 1 )

data = c.query_latest_adoptions
pp data
puts "---"
sleep( 1 )

data = c.query_latest_donations
pp data
puts "---"
sleep( 1 )

data = c.query_top_collectors
pp data
puts "---"
sleep( 1 )

data = c.query_wrapped
pp data

puts "bye"


