require "zlib"
require "./png-writer.rb"
require "./pixel.rb"
require "./hex_helpers.rb"

writer = PngWriter.new [ [ Pixel.new(255, 0, 0, 1), Pixel.new(0, 0, 255, 1)   ], [ Pixel.new(0, 255, 0, 1), Pixel.new(255, 255, 255, 1) ] ]

writer.write_png "test.png"
