###########
#  to run use:
#    ruby ./doppelganger.rb


$LOAD_PATH.unshift( "../mooncats/lib" )
require 'mooncats'


# Let's try:
# - design 8,9,10,11    - w/ Eyepatch Fur   - all 4 poses (Standing, Sleeping, Pouncing, Stalking)
# - design 12,13,14,15  - w/ Half/Half Fur - all 4 poses
# All designs use Smile (Face) & Left (Facing).



def doppelganger( id, colors: )
  ## note: quick hack? - use empty string ('') for original series for now
  ['', 'v2', 'cryptocats'].each do |series|
    designs, design_nums = case series
                           when 'v2'         then [DESIGNS_V2,         [8,9,10,11, 12,13,14,15]]
                           when 'cryptocats' then [DESIGNS_CRYPTOCATS, [0,1,2,3]]
                           else                   [DESIGNS,            [8,9,10,11, 12,13,14,15]]
                           end


    colors_new = if series == 'cryptocats'
                   # change color order
                   #   note: colors off by one (starting with 0!!)
                   colors_new = colors.dup
                   colors_new[3] = colors[2]    # base
                   colors_new[1] = colors[3]    # pattern 1
                   colors_new[2] = colors[1]    # pattern 2
                   colors_new
                 else
                   colors ## use passed in as is 1:1
                 end



    design_nums.each do |design_num|
      design = designs[ design_num ]


      cat_proto  = Mooncats::Image.new( design: design,
                                        colors: colors_new )

      name = '%03d' % design_num
      name << series

      [1,3].each do |zoom|
        cat = cat_proto
        if zoom > 1
          cat = cat.zoom( zoom )
          name += "x#{zoom}"
        end
        cat.save( "i/#{id}_#{name}.png" )
      end # each zoom
    end # each design
  end # each series
end




## kitty 979522
##   colors:
##     - aquamarine (base color)           - #add5d2
##     - swampgreen (highlight color)      - #44e192
##     - emeraldgreen (accent color)       - #8be179
##     - mintgreen (eye color)             - #43edac
doppelganger( 979522, colors: [
  '#2a2825',   # color 1  -- "black-ish" outline color
  '#8be179',   # color 2 => acc color
  '#add5d2',   # color 3 => base color -- main fur (body) color
  '#44e192',   # color 4 => hi color
  '#43edac'    # color 5 => eye color here - why? why not?
])

## kitty 1925652
##  colors:
##    - orangesoda (base color)          - #f7bc56
##    - royalpurple (highlight color)    - #cf5be8
##    - peach (accent color)            - #f9cfad
##    - cyan (eye color)                - #45f0f4

doppelganger( 1925652, colors: [
  '#2a2825',   # color 1  -- "black-ish" outline color
  '#f9cfad',
  '#f7bc56',
  '#cf5be8',
  '#45f0f4'
])

## kitty 1673550
##   colors:
##     - salmon (base color)           - #f4a792
##     - swampgreen (highlight color)  - #44e192
##     - sandalwood (accent color)     - #b8916c
##     - gold (eye color)              - #fcdf35

doppelganger( 1673550, colors: [
  '#2a2825',   # color 1  -- "black-ish" outline color
  '#b8916c',
  '#f4a792',
  '#44e192',
  '#fcdf35'
])


puts "bye"