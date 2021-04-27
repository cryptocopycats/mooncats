## 3rd party
require 'pixelart/base'
require 'csvreader'


## extra stdlibs
require 'optparse'



## our own code
require 'mooncats/version'    # note: let version always go first
require 'mooncats/designs'
require 'mooncats/structs'
require 'mooncats/design'
require 'mooncats/image'
require 'mooncats/composite'
require 'mooncats/dataset'



module Mooncats
  class Tool
    def run( args )
      opts = { zoom: 1,
               outdir: '.',
             }

      parser = OptionParser.new do |cmd|
        cmd.banner = "Usage: mooncat [options] IDs"

        cmd.separator "  Mint mooncats from original designs - for IDs use 5 byte hexstrings (e.g 0x004fc21270)"
        cmd.separator ""
        cmd.separator "  Options:"

        cmd.on("-z", "--zoom=ZOOM", "Zoom factor x2, x4, x8, etc. (default: #{opts[:zoom]})", Integer ) do |zoom|
          opts[:zoom] = zoom
        end

        cmd.on("-d", "--dir=DIR", "Output directory (default: #{opts[:outdir]})", String ) do |outdir|
          opts[:outdir] = outdir
        end


        cmd.on("-h", "--help", "Prints this help") do
          puts cmd
          exit
        end
      end

      parser.parse!( args )

      puts "opts:"
      pp opts

      puts "    setting zoom to #{opts[:zoom]}x"   if opts[:zoom] != 1

      ## make sure outdir exits (default is current working dir e.g. .)
      FileUtils.mkdir_p( opts[:outdir] )  unless Dir.exist?( opts[:outdir] )

      args.each_with_index do |arg,index|
        cat_id = arg.downcase
        ## note: cut-off optionial 0x
        cat_id = cat_id[2..-1]   if cat_id.start_with?( '0x')

        cat = Image.generate( cat_id )

        cat_name  = "mooncat-#{cat_id}"

        ##  if zoom - add x2,x4 or such
        if opts[:zoom] != 1
          cat = cat.zoom( opts[:zoom] )
          cat_name << "_x#{opts[:zoom]}"
        end

        path  = "#{opts[:outdir]}/#{cat_name}.png"
        puts "==> (#{index+1}/#{args.size}) minting mooncat 0x#{cat_id}; writing to >#{path}<..."

        cat.save( path )
      end

      puts "done"
    end  ## method run
  end # class Tool


  def self.main( args=ARGV )
    Tool.new.run( args )
  end
  end ## module Mooncats


### add some convenience shortcuts
MoonCats = Mooncats




###
# note: for convenience auto include Pixelart namespace!!! - why? why not?
include Pixelart


puts Mooncats.banner    # say hello
