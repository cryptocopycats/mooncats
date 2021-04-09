require 'mooncats'


# Let's try:
# - design 8,9,10,11    - w/ Eyepatch Fur   - all 4 poses (Standing, Sleeping, Pouncing, Stalking)
# - design 12,13,14,15  - w/ Half/Half Fur - all 4 poses
# All designs use Smile (Face) & Left (Facing).

def doppelganger( id, colors: )
  [8,9,10,11, 12,13,14,15].each do |design|
    [1,3].each do |zoom|
      cat = Mooncats::Image.new( design: design,
                                 colors: colors,
                                 zoom: zoom )
      name = '%03d' % design
      name << "x#{zoom}" if zoom > 1

      cat.save( "i/#{id}_#{name}.png" )
    end
  end
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
