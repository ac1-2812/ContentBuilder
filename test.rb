require "zlib"
require "./png-writer.rb"
require "./pixel.rb"
require "./noise-generators/perlin-noise.rb"

pixels = []
256.times do |row|
  row_items = []

  256.times do |column|
    row_items.push Pixel.new(0, 0, 0, 255)
  end

  pixels.push row_items
end

noise_generator = NoiseGenerators::PerlinNoise.new

pixels.each.with_index do |row, row_number|
  row.each.with_index do |pixel, column|
    color = (noise_generator.octave_perlin row_number.to_f, column.to_f, 1, 1.to_f).to_i
    pixel.r = color
    pixel.g = color
    pixel.b = color
  end
end

puts "----------------"

pixels.each do |row|
  row.each do |pixel|
    puts "#{pixel.r}, #{pixel.g}, #{pixel.b}"
  end
end

writer = PngWriter.new pixels



writer.write_png "test-output/test.png"
