require 'chunky_png'
require 'fileutils'

class PngWriter
  def initialize pixel_matrix
    @pixel_matrix = pixel_matrix
  end

  public

    def write_png file_path
      png = ChunkyPNG::Image.new(@pixel_matrix.length, @pixel_matrix[0].length, ChunkyPNG::Color::TRANSPARENT)

      @pixel_matrix.each.with_index do |row, row_num|
        row.each.with_index do |pixel, column_num|
          png[row_num, column_num] = ChunkyPNG::Color.rgba(pixel.r, pixel.g, pixel.b, pixel.a)
        end
      end

      FileUtils.mkdir_p file_path.gsub(/\/.*$/, "") unless file_path.scan(/\//).length == 0
      png.save(file_path)
    end
end