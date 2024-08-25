require 'securerandom'
require './hex_helpers.rb'

class PngWriter
  include HexHelpers

  def initialize pixel_matrix
    @pixel_matrix = pixel_matrix
  end

  public

    def write_png file_path
      header = get_png_file_header @pixel_matrix.length, @pixel_matrix[0].length

      File.open(file_path, 'w+b') do |file|
        file.write(header)
      end
    end

    def get_png_file_header width, height
      width_bytes = resolve_int_to_fixed_length_hex width, 8
      height_bytes = resolve_int_to_fixed_length_hex height, 8

      hex_header = "\x49\x48\x44\x52#{width_bytes}#{height_bytes}\x08\x02\x00\x00\x00"
      header_crc32 = resolve_crc hex_header

      "\x89\x50\x4E\x47\x0D\x0A\x1A\x0A\x00\x00\x00\x0D#{hex_header}#{header_crc32}"
    end
end