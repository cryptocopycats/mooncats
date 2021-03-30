

module Mooncats
  module Dataset

    def self.read( path='./datasets/mooncats/*.csv' )

      datasets = Dir.glob( path )
      ## pp datasets
      #=> ["./datasets/mooncats/00.csv",
      #    "./datasets/mooncats/01.csv",
      #    "./datasets/mooncats/02.csv",
      #    "./datasets/mooncats/03.csv",
      #    "./datasets/mooncats/04.csv",
      #     ...]

      rows = []
      datasets.each do |dataset|
        rows += CsvHash.read( dataset )
      end

      ## puts "  #{rows.size} rows(s)"
      #=> 25440 rows(s)


      ### wrap in mooncat struct for easier access
      mooncats = []
      rows.each_with_index do |row,i|
        ## print "."  if i % 100
        id    = row['id']
        ## note: skip all derived column from id e.g.
        ##        - r,g,b, etc.

        ## add some more (extra) columns
        mint      = row['mint'].to_i
        block     = row['block'].to_i
        ## expected timestamp format like
        ##   2017-09-06 15:03:43 UTC
        timestamp = DateTime.strptime( row['timestamp'], '%Y-%m-%d %H:%M:%S %z')

        mooncats << Metadata.new( id,
                                  mint:      mint,
                                  block:     block,
                                  timestamp: timestamp )
      end
      ## print "\n"   ## add progress

      mooncats
    end
  end  # module Dataset
end  # module Mooncat


