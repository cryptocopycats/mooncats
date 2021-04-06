$LOAD_PATH.unshift( "../cryptocopycats/mooncats/mooncats-graphql/lib" )
require 'mooncats/graphql'



def load_state
  if File.exist?( './state.json' )   # Starting from existing transaction list"
    text = File.open( './state.json', 'r:utf-8') { |f| f.read }
    state = JSON.parse( text )
  else
    puts "Initializing new transaction list"
    state = {
      't'     =>  0,
      'txns'  => [],
    }
  end
end

def save_state( state )
  File.open( './state.json', 'w:utf-8') do |f|
    f.write( JSON.pretty_generate( state ))
  end
end



def dedup( txns )
  clean_txns = []
  all_ids = {}

  txns.each do |txn|
     ## note: tx id is missing - check back if possible to get / query?
     ##    use / build our own (unique?) composite id/key for now
     id = "#{txn['time']}/#{txn['cat']['id']}/#{txn['to']['id']}-#{txn['from']['id']}"
     next if all_ids.has_key?( id )

     clean_txns << txn
     all_ids[ id ] = true
  end
  clean_txns
end




QUERY_ADOPTIONS =<<GRAPHQL
{
  adoptions(first: $first,
            orderBy: time,
            where: {time_gte: $last_time}) {
    cat {
      id
    }
    price
    time
    block
    to {
      id
    }
    from {
      id
    }
    isWrapping
  }
}
GRAPHQL




def get_latest_txns
  state = load_state
  t     = state['t']
  txns  = state['txns']

  puts "So far have %d txns. Getting all new txns since %d" % [txns.size, t]

  c = Mooncats::GraphQL::Client.new

  first = 1000
  loop do
    query = QUERY_ADOPTIONS
    query = query.gsub( '$first',     first.to_s )
    query = query.gsub( '$last_time', t.to_s )

    res = c.query( query )

    data = res['data']['adoptions']

    t = data[-1]['time']
    puts "First time was %d and last time was %d" % [data[0]['time'], t]

    txns += data

    puts "Extended txns by %d for a total of %d" % [data.size, txns.size]
    break  if data.size < 1000

    sleep(1)   # avoid being throttled
  end


  txns = dedup( txns )

  puts "After deduplication, got %d transactions" % txns.size

  state['t']    = t
  state['txns'] = txns
  save_state( state )

  txns
end


get_latest_txns


puts "bye"

