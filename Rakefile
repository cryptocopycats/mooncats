require 'hoe'
require './lib/mooncats/version.rb'

Hoe.spec 'mooncats' do

  self.version = Mooncats::VERSION

  self.summary = "mooncats  - mint your own mooncat pixel art images off chain using any of the 128 True Official Genuine Mooncat™ md5-verified original designs; incl. 2x/4x/8x zoom for bigger sizes"
  self.description = summary

  self.urls    = { home: 'https://github.com/cryptocopycats/mooncats' }

  self.author  = 'Gerald Bauer'
  self.email   = 'wwwmake@googlegroups.com'

  # switch extension to .markdown for gihub formatting
  self.readme_file  = 'README.md'
  self.history_file = 'CHANGELOG.md'

  self.extra_deps = [
    ['chunky_png'],
    ['csvreader'],
  ]

  self.licenses = ['Public Domain']

  self.spec_extras = {
    required_ruby_version: '>= 2.3'
  }

end
