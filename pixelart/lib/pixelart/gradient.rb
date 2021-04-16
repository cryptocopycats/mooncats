
## inspired by
##  https://en.wikipedia.org/wiki/List_of_software_palettes#Color_gradient_palettes
##  https://github.com/mistic100/tinygradient
##   https://mistic100.github.io/tinygradient/


module Pixelart

class Gradient

  def initialize( *stops )
    ## note:  convert stop colors to rgb triplets e.g.
    ##         from #ffffff to [255,255,255]
    ##              #000000 to [0,0,0]  etc.
    @stops = stops.map do |stop|
               stop = Color.parse( stop )
               [Color.r(stop), Color.g(stop), Color.b(stop)]
             end
  end


  def colors( steps )
    ## note: for now only support two colors
    ##   note: gradient will include start (first)
    ##     AND stop color (last) - stop color is NOT excluded for now!!
    start = @stops[0]
    stop  = @stops[1]

    step = stepize( start, stop, steps-1 )
    ## pp step

    gradient = [start]

    1.upto(steps-2).each do |i|
       color = interpolate( step, start, i )
       gradient << color
    end
    ## note: use original passed in stop color (should match calculated)
    gradient << stop

    ## convert to color (Integer)
    gradient.map do |color|
      Color.rgb( *color )
    end
 end

##
# Linearly compute the step size between start and end
##  (not normalized)
# @param {StepValue} start
# @param {StepValue} end
# @param {number} steps - number of desired steps
#@return {StepValue}

def stepize(start, stop, steps)
  step = []

  [0,1,2].each do |k|
    step <<  Float(stop[k] - start[k]) / Float(steps)
  end

  step
end

##
# Compute the final step color
#  @param {StepValue} step - from `stepize`
#  @param {StepValue} start
#  @param {number} i - color index
#  @return {StepValue}

RGB_MAX = [256, 256, 256]
def interpolate( step, start, i )
  color = []

  [0,1,2].each do |k|
     color[k] = step[k]*i + start[k]

     color[k] = if color[k] < 0.0
                   color[k] + RGB_MAX[k]
                else
                   color[k] % RGB_MAX[k]
                end

     ## convert back to Integer from Float
     ##   add 0.5 for rounding up (starting with 0.5) - why? why not?
     color[k] = (color[k]+0.5).to_i
  end
  color
end


end  # class Gradient
end  # module Pixelart

