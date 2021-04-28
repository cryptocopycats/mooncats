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
  [8,9,10,11, 12,13,14,15].each do |design_num|
    ## note: quick hack? - use empty string ('') for original series for now
    ['', 'v2'].each do |series|
       design = case series
                when 'v2' then DESIGNS_V2[ design_num ]
                else           DESIGNS[ design_num ]
                end
       cat_proto    = Mooncats::Image.new( design: design,
                                           colors: colors )
       [1,3].each do |zoom|
         cat = cat_proto   ## reuse same original "prototype" image for all zooms
         name = '%03d' % design_num
         name << series

         if zoom > 1
           cat = cat.zoom( zoom )
           name << "x#{zoom}"
         end
         cat.save( "i/#{id}_#{name}.png" )
       end # each zoom
    end # each series
  end # each design
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