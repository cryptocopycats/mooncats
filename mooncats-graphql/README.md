# Mooncats GraphQL


mooncats-graphql - web client (helpers) for using MoonCats (HTTP JSON) GraphQL APIs


* home  :: [github.com/cryptocopycats/mooncats](https://github.com/cryptocopycats/mooncats)
* bugs  :: [github.com/cryptocopycats/mooncats/issues](https://github.com/cryptocopycats/mooncats/issues)
* gem   :: [rubygems.org/gems/mooncats-graphql](https://rubygems.org/gems/mooncats-graphql)
* rdoc  :: [rubydoc.info/gems/mooncats-graphql](http://rubydoc.info/gems/mooncats-graphql)




## Usage

A lite web client wrapper for the Moon Cats Rescue open graph api
powered by the Graph.
See [**thegraph.com/explorer/subgraph/merklejerk/moon-cats-rescue »**](https://thegraph.com/explorer/subgraph/merklejerk/moon-cats-rescue).


``` ruby
require 'mooncats/graphql'

c = Mooncats::GraphQL::Client.new

data = c.query_bestsellers( first: 12 )
```

resulting in:

``` ruby
[{"id"               => "0xff52000ca7",
  "isGenesis"        => true,
  "maxAdoptionPrice" => "55500000000000000000",
  "name"             => nil,
  "rescueBlock"      => 4363303,
  "rescueIndex"      => 2878,
  "rescueTime"       => 1507932258},
 {"id"               => "0xff50000ca7",
  "isGenesis"        => true,
  "maxAdoptionPrice" => "55500000000000000000",
  "name"             => nil,
  "rescueBlock"      => 4363303,
  "rescueIndex"      => 2876,
  "rescueTime"       => 1507932258},
  #...
]
```

Note: Depending on the query either a data array (zero, one or more records)
e.g. `query_bestsellers`
or a hash table or nil  (one or no record) e.g. `query_cat_by_id`
gets returned. Use like:


``` ruby
data.each_with_index do |rec,i|
  print '%2d.  ' % (i+1)
  print '%3d ETH' % (rec['maxAdoptionPrice'].to_i / 1000000000000000000)
  print ' - '
  print rec['id']
  print "\n"
end
```

printing:

```
 1.   55 ETH - 0xff52000ca7
 2.   55 ETH - 0xff50000ca7
 3.   49 ETH - 0x00816eb855
 4.   32 ETH - 0x00ac2b3f23
 5.   13 ETH - 0x00f28bec4f
 6.   12 ETH - 0x00304c8e29
 7.   12 ETH - 0x002179a08d
 8.   10 ETH - 0xff0b000ca7
 9.   10 ETH - 0x0080ea1503
10.    8 ETH - 0x00e38e784c
11.    8 ETH - 0x00c1832514
12.    8 ETH - 0x0002b77279
```


More pre-configured / built-in queries include:


``` ruby
query_cats
query_mint_2017( first: 10 )
query_cat_by_id( id: '0xff52000ca7' )
query_cat_by_wrapper_id( id: 0 )
query_cheap_mints_2017
query_latest_adoptions
query_latest_donations
query_top_collectors
query_wrapped
```

See the [query source](lib/mooncats/graphql/query.rb) for more.



### Pagination - 1000 Records Max. Limit / Request

Note:  The open graph api has a 1000 records limit per request.
The recommended way for pagination is to use
a greater than last record id in the where clause in the query
to get the next page / batch.
Example - `query_cats`:

```  graphql
{
  cats(first: 1000,
       where: { id_gt: $last_id }) {
    id
    # ...
  }
}
```

Get all 25 440 MoonCat blockchain data
in 26 batches / requests of a thousand each:

``` ruby
# ~26 000 mooncats - download in 26 batches of 1000 each
last_id = '0x0000000000'
26.times do |i|
  puts "downloading batch #{i}..."
  data = c.query_cats( last_id: last_id )
  puts "  #{data.size} records(s)"

  ## process data here

  last_id = data[-1]['id']    ## get id from last record using index -1
  puts "  last_id: #{last_id}"
  sleep( 1 )
end
```

resulting in:

```
downloading batch 0...
  1000 record(s)
  last_id: 0x000a05b9ac
downloading batch 1...
  1000 record(s)
  last_id: 0x0013b68a2f
...
```

That's it.



## New to MoonCats?

See the
[**Programming MoonCats & MarsCats Step-by-Step Booklet / Guide »**](https://github.com/cryptocopycats/programming-mooncats)




## Install

Just install the gem:

    $ gem install mooncats-graphql


## License

The scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?

Post them on the [mooncatrescue reddit](https://www.reddit.com/r/mooncatrescue). Thanks.




