# Cool Cats Experiment

Mint Yourself Free MoonCats with Sun Glasses


Here's the experiment - let's design some sun glasses
and let's turn "plain vanilla" mooncats into cool cats with shades.


Let's use the original online pixel tool (see => [**mooncatrescue.com/pixeleditor**](https://mooncatrescue.com/pixeleditor) )
to draw all-black sun glasses in 12x3 size.


![](i/pixel-shades1.png)

Tip: Use the print button to export the sun glasses into
a ready-to-cut-n-paste pixel matrix.


Let's try:

``` ruby
shades1 = Image.parse( <<TXT, colors: ['000000'] )
1 1 1 1 1 1 1 1 1 1 1 1
0 0 1 1 1 1 0 1 1 1 1 0
0 0 0 1 1 0 0 0 1 1 0 0
TXT

shades1.save( './shades1.png' )
shades1.zoom(4).save( './shades1x4.png' )
```

Resulting in:

![](i/shades1.png)
![](i/shades1x4.png)



Let's add the shades to the first four designs (0, 1, 2, 3)
with the four poses, that is, standing (21×17),
sleeping (20×14), pouncing (17×22),
and stalking (20×21).


![](i/mooncat-000.png)
![](i/mooncat-001.png)
![](i/mooncat-002.png)
![](i/mooncat-003.png)

![](i/mooncat-000x4.png)
![](i/mooncat-001x4.png)
![](i/mooncat-002x4.png)
![](i/mooncat-003x4.png)


``` ruby
head_offsets = [
  [0,3],  # pose - standing (21×17)
  [1,3],  # pose - sleeping (20×14)
  [1,3],  # pose - pouncing (17×22)
  [0,9],  # pose - stalking (20×21)
]

## (standard/default) colors from the original online mooncat pixel drawing tool
colors = ['331a00', '663300', 'e67300', 'ffb366', 'ff9999' ]

designs = [0,1,2,3]
designs.each do |design|
  cat = Mooncats::Image.new( design: design, colors: colors )

  x, y = head_offsets[ design % 4 ]
  cat.compose!( shades1, x-1, y+2 )

  name = '%03d' % design
  cat.save( "./coolcat-#{name}_1.png" )
  cat.zoom(4).save( "./coolcat-#{name}_1x4.png" )
end
```

Resulting in:


![](i/coolcat-000_1.png)
![](i/coolcat-001_1.png)
![](i/coolcat-002_1.png)
![](i/coolcat-003_1.png)

![](i/coolcat-000_1x4.png)
![](i/coolcat-001_1x4.png)
![](i/coolcat-002_1x4.png)
![](i/coolcat-003_1x4.png)



Let's draw and try another sunglasses design:

![](i/pixel-shades2.png)

``` ruby
shades2 = Image.parse( <<TXT, colors: ['000000', '690C45', '8C0D5B', 'AD2160'] )
0 1 1 1 1 1 0 1 1 1 1 1
0 1 2 2 2 1 1 1 2 2 2 1
1 1 3 3 3 1 0 1 3 3 3 1
0 1 4 4 4 1 0 1 4 4 4 1
0 0 1 1 1 0 0 0 1 1 1 0
TXT

shades2.save( './shades2.png' )
shades2.zoom(4).save( './shades2x4.png' )
```

Resulting in:

![](i/shades2.png)
![](i/shades2x4.png)

And

![](i/coolcat-000_2.png)
![](i/coolcat-001_2.png)
![](i/coolcat-002_2.png)
![](i/coolcat-003_2.png)

![](i/coolcat-000_2x4.png)
![](i/coolcat-001_2x4.png)
![](i/coolcat-002_2x4.png)
![](i/coolcat-003_2x4.png)



And let's draw and try another sunglasses design:

![](i/pixel-shades3.png)

``` ruby
shades3 = Image.parse( <<TXT, colors: ['000000', '990033', 'FF0066', 'FF3366'] )
1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
0 1 1 2 2 2 2 1 2 2 2 2 1 1 0
0 0 1 3 3 3 3 1 3 3 3 3 1 0 0
0 0 1 4 4 1 1 1 1 1 4 4 1 0 0
0 0 1 1 1 1 0 0 0 1 1 1 1 0 0
TXT

shades3.save( './shades3.png' )
shades3.zoom(4).save( './shades3x4.png' )
```

Resulting in:

![](i/shades3.png)
![](i/shades3x4.png)

And

![](i/coolcat-000_3.png)
![](i/coolcat-001_3.png)
![](i/coolcat-002_3.png)
![](i/coolcat-003_3.png)

![](i/coolcat-000_3x4.png)
![](i/coolcat-001_3x4.png)
![](i/coolcat-002_3x4.png)
![](i/coolcat-003_3x4.png)



And let's draw and try another sunglasses design:

![](i/pixel-shades4.png)

``` ruby
shades4 = Image.parse( <<TXT, colors: ['000000', '000766', '0010e6'] )
1 1 1 1 1 1 1 1 1 1 1 1
0 0 1 2 2 1 0 1 2 2 1 0
0 0 1 3 3 1 0 1 3 3 1 0
0 0 0 1 1 0 0 0 1 1 0 0
TXT

shades4.save( './shades4.png' )
shades4.zoom(4).save( './shades4x4.png' )
```

Resulting in:

![](i/shades4.png)
![](i/shades4x4.png)

And

![](i/coolcat-000_4.png)
![](i/coolcat-001_4.png)
![](i/coolcat-002_4.png)
![](i/coolcat-003_4.png)

![](i/coolcat-000_4x4.png)
![](i/coolcat-001_4x4.png)
![](i/coolcat-002_4x4.png)
![](i/coolcat-003_4x4.png)



That's it for now.  Now design your own sunglasses. Yes, you can!


<!--
## Future Directions  - Ideas for Improvments

- Paste the mooncat image into a bigger (extended) canvas before adding the sunglasses.
 Why?  On some design (with an offset of -1 or -2) some parts of the sunglasses on the left-side get "cut-off".


Your Ideas Here
-->



## Questions? Comments?

Post them on the [mooncatrescue reddit](https://old.reddit.com/r/mooncatrescue). Thanks.
