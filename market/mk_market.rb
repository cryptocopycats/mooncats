require 'json'
require 'pp'
require 'date'
require 'time'
require 'fileutils'


def get_prices
  text = File.open( './state.json', 'r:utf-8') { |f| f.read }
  state = JSON.parse( text )
  txns = state['txns']
  txns
end



recs = get_prices
pp recs[0..2]

puts " #{recs.size} record(s)"


events = {}   ## get recs by year / month / day

recs.each_with_index do |h,i|
   time = Time.at( h['time'] ).utc

   year  = events[ time.year ] ||= { }
   month = year[ time.month] ||= {}
   day   = month[ time.day ] ||= []
   day   << [ h['time'],
              h['block'],
              h['cat']['id'],
              h['price'].to_i,   ## note: convert string to number e.g. "0" to 0
              h['from']['id'],
              h['to']['id'],
              h['isWrapping']]
end



def save_records( path, recs, columns: )
  FileUtils.mkdir_p( File.dirname( path ) ) unless Dir.exist?( File.dirname( path ) )

  File.open( path, 'w:utf-8') do |f|
    f.write( columns.join( ', ' ))
    f.write( "\n")

    recs.each do |values|
     f.write( values.join( ', ' ))
     f.write( "\n")
    end
  end
end



events.each do |year,months|
  puts "==> year: #{year}"
  months.each do |month, days|
    puts "    month: #{month}"
    days.each do |day, recs|

      ## note: filter out all from == to  -- check for price == 0 too - why? why not?
      recs = recs.select do |rec|
                            price = rec[3]
                            from  = rec[4]
                            to    = rec[5]
                            !(from == to && price == 0)
                         end

      puts "       #{day} -  #{recs.size} record(s)"

      wei_per_eth = 1_000_000_000_000_000_000 ## wei (10^18)
      recs = recs.map do |old_rec|
               rec = []
               time = Time.at( old_rec[0] ).utc
               rec << "#{time}"

               rec << old_rec[2]  ## id

               if old_rec[3] == 0   ## gift / donation transfer
                 rec << '-'
                 rec << '-'
               else
                 eth = Float(old_rec[3]) / Float(wei_per_eth)
                 rec << ('%f' % eth)   ## price (in eth)
                 rec << old_rec[3]     ## price (in wei)
               end

               if old_rec[4] == '0x7c40c393dc0f283f318791d746d894ddd3693572'
                  rec << 'WrappedMoonCatRescue (WMCR)'
                  ## puts "!! mooncat unwrapped"
               else
                  rec << old_rec[4]   ## from
               end

               if old_rec[5] == '0x7c40c393dc0f283f318791d746d894ddd3693572'
                 rec << 'WrappedMoonCatRescue (WMCR)'
                 if old_rec[6] == false
                    puts "!! error - mooncat wrapped but not flagged"
                    exit 1
                 end
               else
                 rec << old_rec[5]   ## to
                 if old_rec[6] == true
                  puts "!! error - mooncat wrapped flag but unknown address"
                  exit 1
                end
               end

               rec << old_rec[1]  ## block
               rec
             end

      path = "./o/adopt/#{year}/#{year}-#{'%02d' % month}-#{'%02d' % day}_(#{recs.size}).csv"
      save_records( path, recs,
                    columns: ['timestamp',
                              'id',
                              'price (in eth)',
                              'price (in wei)',
                              'from',
                              'to',
                              'block'] )

      ## filter out all free transfers - price zero (0) e.g. -,-
      recs = recs.select do |rec|
                            price = rec[2]
                            price != '-'
                         end
      recs = recs.map do |rec|
                          rec[0..3]   ## cut-off from, to, block etc.
                       end


      puts "       #{day} -  #{recs.size} record(s)"
      next if recs.size == 0    ## note: skip if no sales transaction left in records

      path = "./o/prices/#{year}/#{year}-#{'%02d' % month}-#{'%02d' % day}_(#{recs.size}).csv"
      save_records( path, recs,
                    columns: ['timestamp',
                              'id',
                              'price (in eth)',
                              'price (in wei)'] )

    end
  end
end


puts "bye"

