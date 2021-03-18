

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

        mint  = row['mint'].to_i

        mooncats << Metadata.new( id )
      end
      ## print "\n"   ## add progress

      mooncats
    end
  end  # module Dataset
end  # module Mooncat


