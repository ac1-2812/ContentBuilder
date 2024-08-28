require "zlib"
require "./png-writer.rb"
require "./pixel.rb"

writer = PngWriter.new [ [ Pixel.new(255, 0, 0, 255), Pixel.new(0, 0, 255, 255)   ], [ Pixel.new(0, 255, 0, 255), Pixel.new(255, 255, 255, 255) ] ]

writer.write_png "test-output/test.png"
