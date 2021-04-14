# LED Light Pixel Art Experiment


Mint yourself free MoonCats in the LED Light pixel art series.


Here's the experiment - let's turn ~24x24 pixelated MoonCats
into LED Light art.

How?

1. Let's use a black background.
2. Let's turn pixels into LEDs by scaling up the pixel (e.g. 8x).
3. Let's add spacing between the LEDs (e.g. 2 pixels).




## Mooncat 0x0077c8278d

Let's try mooncat 0x0077c8278d. Let's mint a fresh copy.



``` ruby
require 'mooncats'

Mooncats::Image.mint( '0x0077c8278d' ).save( './mooncat-0077c8278d.png' )
```

![](i/mooncat-0077c8278d.png)



And let's try three LED Light variants:

1.  LED - 8 pixels, Spacing - 2 pixels   (the default)
2.  LED - 16 pixels, Spacing - 3 pixels
3.  LED - 16 pixels, Spacing - 8 pixels, Round Corner - Turned On


``` ruby
require 'pixelart'

cat = Pixelart::Image.read( './mooncat-0077c8278d.png' )
puts " #{cat.width}x#{cat.height}"

cat_led = cat.led( 8, spacing: 2 )
cat_led.save( './mooncat-0077c8278d_led8x.png' )

cat_led = cat.led( 16, spacing: 3 )
cat_led.save( './mooncat-0077c8278d_led16x.png' )

cat_led = cat.led( 16, spacing: 8, round_corner: true )
cat_led.save( './mooncat-0077c8278d_led16xr.png' )
```

And Voila!


![](i/mooncat-0077c8278d_led8x.png)

![](i/mooncat-0077c8278d_led16x.png)

![](i/mooncat-0077c8278d_led16xr.png)







