# MoonCat Art Challenge #1 Experiment -  Dotty Spotty "Currency" MoonCats Inspired by Damien Hirst's "The Currency"


See
the [**Punk Art Challenge #1**](https://old.reddit.com/r/CryptoPunksDev/comments/pttf4s/punk_art_challenge_1_10_000_dotty_spotty_currency/)
for more background
and change ~Punk~ to MoonCat :-).




Okkie. Welcome back.
Let's give it a try using
the mooncat  ![](i/mooncat-0077c8278d.png) 0x0077c8278d.


Let's start with 10px circles -
resulting in a 24*10px = 240×240px format:


``` ruby
mooncat.spots( 10 )
```

![](i/spots-0077c8278d.png)


Let's try a 2x zoom with quadruple (2×2=4) the pixels
and a random circle radius
between 3px and 6px
and a random x/y-offset from the circles center by +/-1px:


``` ruby
mooncat.zoom(2).spots( 5, spacing: 5,
                          center: [-1,1], radius: [3,6] )
```

![](i/spots-0077c8278d@2x.png)




What's missing?  Let's try "random" background spots
inspired by Damien Hirst's $40+ million "The Currency"
art collection.

``` ruby
BACKGROUND_SPOTS = [
 # blue-ish
 '49355E', '16437A', '096598', '4B8BBB', '9CD9DE', 'C5A7C6',
 # red-ish
 'A5282C', 'D14C37', 'CF6A71', 'DD5E36', 'DDA315', 'F3A925',
 # green-ish
 '4C7031', '95A025', '66BA8C', '316D5F',
 # gray-ish /white-ish
 'C2B6AF', 'BFC0C5', '3BC8B5',
]
```

Change the currency spot colors to your liking. The background spots
get selected randomly.
Let's try:


``` ruby
mooncat.zoom(2).spots( 5, spacing: 5,
                      center: [-1,1], radius: [3,6],
                      background: BACKGROUND_SPOTS )
```

![](i/currency-v1-0077c8278d@2x.png)



Let's make the spots bigger
with a radius between 2px and 8px
and the offset more random -/+3px:

``` ruby
mooncat.zoom(2).spots( 5, spacing: 5,
                      center: [-3,3], radius: [2,8],
                      background: BACKGROUND_SPOTS )
```


![](i/currency-v2-0077c8278d@2x.png)


## Bonus - Free High-Definition (Hi-Def) XXXL Poster-Size Quality Edition

One more thing - let's go high definition (hi-def), yes, XXXL
with poster-size quality thanks to vector graphics.
Let's try:

``` ruby
mooncat.zoom(2).spots_hidef( 5, spacing: 5,
                            center: [-3,3], radius: [2,8],
                            background: BACKGROUND_SPOTS )
```

![](i/currency-v2-0077c8278d@2x.svg)


High-definition (hi-def) XXXL!? Yes, it's all text in the scalable vector graphics (svg) format. For example, open up [**currency-v2-0077c8278d@2x.svg**](https://github.com/cryptocopycats/mooncats/raw/master/spots/i/currency-v2-0077c8278d@2x.svg) in your browser and zoom in 100%, 200%, 300%, .. and so on and yes, the quality stays hi-definition (hi-def)!



That's it for now to get you started.



## Questions? Comments?

Post them on the [mooncatrescue reddit](https://old.reddit.com/r/mooncatrescue). Thanks.
