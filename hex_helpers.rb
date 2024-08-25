require 'zlib'

module HexHelpers
  def resolve_int_to_fixed_length_hex int, length
    hex_bytes = "%.#{length}X" % int
    (length - hex_bytes.length).times { hex_bytes = "\x00#{hex_bytes}" }
    puts [hex_bytes].pack("H*")
    [hex_bytes].pack("H*")
  end

  def resolve_crc input
    crc32 = Zlib::crc32(input)

    packed_crc32 = [crc32.to_s(16)].pack("H*")
    packed_crc32.force_encoding("UTF-8")

    packed_crc32
  end
end