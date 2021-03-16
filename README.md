# Mooncats

mooncats  - mint your own mooncat pixel art images off chain using any of the 128 True Official Genuine Mooncat™ md5-verified original designs; incl. 2x/4x/8x zoom for bigger sizes

* home  :: [github.com/cryptocopycats/mooncats](https://github.com/cryptocopycats/mooncats)
* bugs  :: [github.com/cryptocopycats/mooncats/issues](https://github.com/cryptocopycats/mooncats/issues)
* gem   :: [rubygems.org/gems/mooncats](https://rubygems.org/gems/mooncats)
* rdoc  :: [rubydoc.info/gems/mooncats](http://rubydoc.info/gems/mooncats)


New to Mooncats?
See the [**Awesome MoonCatRescue Bubble (Anno 2021) - Modern Crypto Pixel Art on the Blockchain** »](https://github.com/cryptocopycats/awesome-mooncatrescue-bubble)



## Command Line

Use the `mooncat` command line tool. Try:

```
$ mooncat -h
```

resulting in:

```
Usage: mooncat [options] IDs
  Mint mooncats from original designs - for IDs use 5 byte hexstrings (e.g 0x004fc21270)

  Options:
    -z, --zoom=ZOOM     Zoom factor x2, x4, x8, etc. (default: 1)
    -d, --dir=DIR       Output directory (default: .)
    -h, --help          Prints this help
```


Now let's give it a try.  Let's mint mooncats 0x00000800fa,
0x0077c8278d, and 0xff5f000ca7:


```
$ mooncat 0x00000800fa 0x0077c8278d 0xff5f000ca7
```

printing:

```
==> (1/3) minting mooncat 0x00000800fa; writing to >./mooncat-00000800fa.png<...
            design #0 (21x17)
==> (2/3) minting mooncat 0x0077c8278d; writing to >./mooncat-0077c8278d.png<...
            design #119 (20x21)
==> (3/3) minting mooncat 0xff5f000ca7; writing to >./mooncat-ff5f000ca7.png<...
            design #95 (20x21)
```

And voila!

![](i/mooncat-00000800fa.png)
![](i/mooncat-0077c8278d.png)
![](i/mooncat-ff5f000ca7.png)



**Bonus:  Try the `-z/--zoom` factor x2, x4, x8, etc.**

Let's give it a try.  Let's mint mooncat 0x00000800fa,
0x0077c8278d, and 0xff5f000ca7 in 2x format:

```
$ mooncat --zoom 2 0x00000800fa 0x0077c8278d 0xff5f000ca7
# -or-
$ mooncat -z2 00000800fa 0077c8278d ff5f000ca7
```

printing:

```
    setting zoom to 2x
==> (1/3) minting mooncat 0x00000800fa; writing to >./mooncat-00000800fa_x2.png<...
          design #0 (21x17)
==> (2/3) minting mooncat 0x0077c8278d; writing to >./mooncat-0077c8278d_x2.png<...
          design #119 (20x21)
==> (3/3) minting mooncat 0xff5f000ca7; writing to >./mooncat-ff5f000ca7_x2.png<...
          design #95 (20x21)
```

And voila!

![](i/mooncat-00000800fa_x2.png)
![](i/mooncat-0077c8278d_x2.png)
![](i/mooncat-ff5f000ca7_x2.png)


And x4:

![](i/mooncat-00000800fa_x4.png)
![](i/mooncat-0077c8278d_x4.png)
![](i/mooncat-ff5f000ca7_x4.png)


And x8:

![](i/mooncat-00000800fa_x8.png)
![](i/mooncat-0077c8278d_x8.png)
![](i/mooncat-ff5f000ca7_x8.png)



And so on.


## Usage in Your Scripts


Yes, you can mint mooncats in your own scripts
and much more.
See the
[**Programming Mooncats Step-by-Step Booklet / Guide »**](https://github.com/cryptopunksnotdead/programming-mooncats)  - Upcoming



## Install

Just install the gem:

    $ gem install mooncats


## License

The scripts are dedicated to the public domain.
Use it as you please with no restrictions whatsoever.


## Questions? Comments?

Post them on the [mooncatrescue reddit](https://www.reddit.com/r/mooncatrescue). Thanks.
