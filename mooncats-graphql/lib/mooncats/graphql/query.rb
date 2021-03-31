
module Mooncats
module GraphQL

  class Client < ::Mooncats::Client
    def initialize
      super( base_uri: 'https://api.thegraph.com/subgraphs/name/merklejerk/moon-cats-rescue' )
    end


    def query_bestsellers( first: 100,
                           includes: [] )
      query = <<GRAPHQL
      {
        cats(first: $first, orderBy: maxAdoptionPrice, orderDirection: desc) {
          id
          rescueIndex
          rescueBlock
          rescueTime
          name
          isGenesis
          maxAdoptionPrice
          #  @INCLUDES - lets you add more fields e.g. maxAdoptionPrice etc.
        }
      }
GRAPHQL
      query = query.gsub( '$first',   first.to_s )

      data = query( query, includes: includes )
      data['data']['cats']   ## return nested data
    end

    def query_cheap_mints_2017( first: 100,
                                includes: [] )
      query = <<GRAPHQL
      {
  cats(first: $first, orderBy: askPrice,
       where: {rescueTime_lt: 1514764800, askPrice_gt: 0}) {
    id
    name
    rescueIndex
    rescueTime
    askPrice
    #  @INCLUDES - lets you add more fields e.g. maxAdoptionPrice etc.
  }
}
GRAPHQL
      query = query.gsub( '$first',   first.to_s )

      data = query( query, includes: includes )
      data['data']['cats']   ## return nested data
    end


    def query_mint_2017( first: 100,
                         last_rescue_index: -1,
                         includes: [] )
      query = <<GRAPHQL
      {
        cats(first: $first,     ## note: max is 1000
              orderBy: rescueIndex,
              where:
              { rescueTime_lt: 1514764800,
                rescueIndex_gt: $last_rescue_index   ## for paging in batches of 1000
              }) {
          id
          rescueIndex
          rescueBlock
          rescueTime
          name
          #  @INCLUDES - lets you add more fields e.g. maxAdoptionPrice, askPrice,  etc.
        }
      }
GRAPHQL
      query = query.gsub( '$first',              first.to_s )
      query = query.gsub( '$last_rescue_index',  last_rescue_index.to_s )

      data = query( query, includes: includes )
      data['data']['cats']
    end


    def query_cats( first: 1000,
                     last_id: '0x00',
                     includes: [] )
      query = <<GRAPHQL
      {
        cats(first: $first,   ## note: max is 1000
              where: { id_gt: $last_id }) {
          id
          rescueIndex
          rescueBlock
          rescueTime
          name
          #  @INCLUDES - lets you add more fields e.g. maxAdoptionPrice, askPrice, etc.
        }
      }
GRAPHQL
      query = query.gsub( '$first',   first.to_s )
      query = query.gsub( '$last_id',  %Q<"#{last_id}"> )

      data = query( query, includes: includes )
      data['data']['cats']
    end


    def query_cat_by_id( id:,
                         includes: [] )
      query = <<GRAPHQL
      {
        cat(id: $id) {
          id
          rescueIndex
          rescueTime
          name
          isGenesis
          maxAdoptionPrice
          wrapperTokenId
          owner {
            id
          }
          bid {
            price
          }
          ask {
            price
          }
          #  @INCLUDES - lets you add more fields e.g. maxAdoptionPrice, askPrice,  etc.
        }
      }
GRAPHQL
      query = query.gsub( '$id',  %Q<"#{id}"> )

      data = query( query, includes: includes )
      data['data']['cat']   ## note: returns single (one-only) cat record
    end


    def query_cat_by_wrapper_id( id:,
                                 includes: [] )
    query = <<GRAPHQL
    {
      cats(where: {wrapperTokenId: $wrapper_token_id}) {
        id
        rescueIndex
        rescueTime
        name
        isGenesis
        maxAdoptionPrice
        wrapperTokenId
        owner {
          id
        }
        bid {
          price
        }
        ask {
          price
        }
        #  @INCLUDES - lets you add more fields e.g. maxAdoptionPrice, askPrice,  etc.
      }
    }
GRAPHQL
    query = query.gsub( '$wrapper_token_id',  id.to_s )

    data = query( query, includes: includes )
    data['data']['cats'][0]   # note: try to get first record only (by default) - why? why not?
  end

   def query_latest_adoptions( first: 100,
                               includes: [] )
     query = <<GRAPHQL
    {
      adoptions(first: $first, orderBy: time, orderDirection: desc,
                where: {price_gt: 0}) {
        cat {
          id
          rescueIndex
          isGenesis
        }
        time
        price
        to {
          id
        }
        #  @INCLUDES - lets you add more fields e.g. maxAdoptionPrice, askPrice,  etc.
      }
    }
GRAPHQL
    query = query.gsub( '$first',  first.to_s )

    data = query( query, includes: includes )
    data['data']['adoptions']
  end
  alias_method :query_recent_adoptions, :query_latest_adoptions


  def query_latest_donations( first: 100,
                              includes: [] )
    query = <<GRAPHQL
    {
      adoptions(first: $first, orderBy: time, orderDirection: desc,
         where: {price: 0, isWrapping: false}) {
        cat {
          id
          rescueIndex
          isGenesis
        }
        time
        to {
          id
        }
        #  @INCLUDES - lets you add more fields e.g. maxAdoptionPrice, askPrice,  etc.
      }
    }
GRAPHQL
    query = query.gsub( '$first',  first.to_s )

    data = query( query, includes: includes )
    data['data']['adoptions']
  end
  alias_method :query_recent_donations, :query_latest_donations


  def query_top_collectors( first: 10,
                            includes: [] )
     query = <<GRAPHQL
  {
  owners(first: $first, orderBy: catCount, orderDirection: desc,
    where: {isWrapper: false}) {
    id
    catCount
  }
}
GRAPHQL
    query = query.gsub( '$first',  first.to_s )

    data = query( query, includes: includes )
    data['data']['owners']
  end


  def query_wrapped( first: 100,
                     last_rescue_index: -1,
                     includes: [] )
  query = <<GRAPHQL
{
  cats(first: $first, orderBy: rescueIndex,
        where:
        { wrapperTokenId_not: null,
          rescueIndex_gt: $last_rescue_index   ## for paging in batches of 1000
         }) {
    id
    rescueIndex
    isGenesis
    name
    wrapperTokenId
    wrapperOwner {
      id
    }
    #  @INCLUDES - lets you add more fields e.g. maxAdoptionPrice, askPrice,  etc.
  }
}
GRAPHQL
    query = query.gsub( '$first',              first.to_s )
    query = query.gsub( '$last_rescue_index',  last_rescue_index.to_s )

    data = query( query, includes: includes )
    data['data']['cats']
  end





    #####
    #  generic query via HTTP POST
    def query( query, includes: [] )
      if includes.size > 0
        ## check for end-of-line comments with @INCLUDES marker
         query = query.gsub( /[#]+[ ]+@INCLUDES[^\n\r]+/,
                               includes.join( ' ' ) )
      end

      post( query: query )
    end


  end # class Client
end # module GraphQL
end # module Mooncats


