###########
#  to run use:
#    ruby ./colorize.rb

$LOAD_PATH.unshift( "../mooncats/lib" )
require 'mooncats'


# Let's try:
# - design 8,9,10,11    - w/ Eyepatch Fur   - all 4 poses (Standing, Sleeping, Pouncing, Stalking)
# - design 12,13,14,15  - w/ Half/Half Fur - all 4 poses
# All designs use Smile (Face) & Left (Facing).


def colorize( name, colors: )

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

      cat_proto = Mooncats::Image.new( design: design,
                                       colors: colors_new )
      [1,3].each do |zoom|
        cat = cat_proto    ## reuse same original "prototype" image for all zooms
        name = name.downcase.gsub( ' ', '_' )  ## slugify name

        name_plus = '%03d' % design_num
        name_plus << series

        if zoom > 1
          cat = cat.zoom( zoom )
          name_plus << "x#{zoom}"
        end

        cat.save( "i/#{name}_#{name_plus}.png" )
      end
    end
  end
end





################
## 5 color schemes


##  24 Karat Gold
## see https://www.schemecolor.com/24-karat-gold-color-palette.php

colorize( '24 Karat Gold', colors: [
  '#A67C00',  # Gold
  '#FFCF40',  # Sunglow
  '#FFBF00',  # Fluorescent Orange
  '#BF9B30',  # Satin Sheen Gold
  '#FFDC73',  # Crayola's Dandelion
])


##  Vivid Green (Layer)
## see https://www.schemecolor.com/vivid-green-layer.php

colorize( 'Vivid Green', colors: [
  '#0AAF30', # Pantone Green
  '#2CE71E', # Neon Green
  '#66FF01', # Bright Green
  '#00CC32', # Vivid Malachite
  '#A4FF00', # Spring Bud
])


##  (Selective) Valentine
## https://www.schemecolor.com/selective-valentine-color-scheme.php

colorize( 'Valentine', colors: [
  '#CE0A0A', # Venetian Red
  '#EE0E30', # Medium Candy Apple Red
  '#E71958', # Spanish Crimson
  '#EE1E87', # Electric Pink
  '#EC35B6', # Frostbite
])




##  Ferrari
## see https://www.schemecolor.com/ferrari.php

colorize( 'Ferrari', colors: [
  '#000000',  # Black
  '#FFFFFF',  # White
  '#ED1C24',  # Pigment Red
  '#009A4E',  # Spanish Green
  '#FFF200',  # Yellow Rose
])


## Google (Pay)
##  see https://www.schemecolor.com/google-pay.php

colorize( 'Google', colors: [
  '#5F6368', # Granite Gray
  '#EA4335', # Cinnabar
  '#3A81F1', # Bleu De France
  '#2DA94F', # American Green
  '#FDBD00', # Fluorescent Orange
])




## ideas/todos.
##  add support for 3 color schemes?
##     use 2nd color to auto-derive missing 2 colors - why? why not?

