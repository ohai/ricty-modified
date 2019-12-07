

module ArrayExpand
  refine Array do
    def expand
      map{|c| Range === c ? c.to_a : c }.flatten(1)
    end
  end
end

using ArrayExpand

module FontGenerator
  module_function

  def east_asian_ambiguous_characters(path = "EastAsianWidth.txt")
    File.open(path) do |f|
      chars = []
      f.each_line do |line|
        next if /\A#/ =~ line
        if /\A([\dA-F]{4});A/ =~ line
          chars << $1.to_i(16)
        end
        if /\A([\dA-F]{4})\.\.([\dA-F]{4});A/ =~ line
          from = $1.to_i(16); to = $2.to_i(16)
          (from .. to).each{|n| chars << n }
        end
      end

      chars.delete_if{|n| n >= 0xE000 } # ignore private-use area
      return chars
    end
  end

  def greek_ambiguous
    [0x391 .. 0x3a1, 0x3a3..0x3a9, 0x3b1..0x3c1, 0x3c3..0x3c9].expand
  end

  def cyrillic_ambiguous
    [ 0x401, 0x410..0x44f, 0x451].expand
  end

  def roman_number_ambiguous
    [0x2160..0x216b, 0x2170..0x2179].expand
  end

  def symbol_ambiguous_fullwidth_noresize
    [0x2032..0x2033,
    ].expand
  end

  def symbol_ambiguous
    [0x2015, 0x2016, 0x2025, 0x203b, 0x2103, # skip to 0x205e
     0x2189, #0/3
     0x2190, 0x2192, 0x2194..0x2199, # arrows
     0x21b8..0x21b9, 0x21d2, 0x21d4, 0x21e7, # arrows
     0x2200, # math symbols
     # 0x2202,  partial differential is removed
     0x2203, 0x2207, 0x2208, 0x220b, 0x220f, 0x2211, 0x221a, # math
     0x221d, 0x221e, 0x221f, 0x2220, 0x2225, 0x2227.. 0x222c, # math
     0x222e, 0x2234..0x2236, # math
     # 0x2237, 0x224c, # math
     0x223d, 0x2252, 0x2260, 0x2261, 0x2266, 0x2267, 0x226a, 0x226b, # math
     # 0x226e, 0x226f, # math
     0x2282, 0x2283, 0x2286, 0x2287, 0x2299, 0x22a5, 0x22bf, 0x2312, # math
     0x2460..0x249b, 0x249c..0x24e9, 0x24eb..0x24ff, # circle with number/alphabet
     #0x2500..0x254b, # box drawing
     #0x2550..0x2573, # box drawing 2
     0x2592..0x2593, 0x25a0..0x25a1, 0x25a3..0x25a9, # blocks
     0x25b2, 0x25b3, 0x25b6, 0x25b7, 0x25bc, 0x25bd, 0x25c0, # triangles and circles
     0x25c1, 0x25c6, 0x25c7, 0x25c8, 0x25cb, 0x25ce, 0x25cf, # |
     0x25e2.. 0x25e5, 0x25ef, 0x2605, 0x2606, # triangle and starts
     0x2609,  0x260e, 0x260f, 0x2614, 0x2615, 0x261c, # various
     0x261e, 0x2640, 0x2642,                          # various
     0x2660, 0x2661, 0x2663, 0x2664, 0x2665, 0x2667, # card symbols
     0x2668, # hotspring
     0x266a, 0x266d, 0x266f, # music symbols
     0x269e, 0x269f, # three lines
     0x26be..0x26bf, 0x26c4..0x26cd, 0x26cf..0x26e1, # emoji?
     0x26e3, 0x26e8..0x26ff, #   |
     0x273d, 0x2757,
     0x2776..0x277f, 0x2b55..0x2b59, 0x3248..0x324f,
    ].expand
  end
  
  # 0x2027
  # 0x226e, 0x226f
end


if __FILE__ == $0
  p FontGenerator.east_asian_ambiguous_characters.size
  p FontGenerator.greek_ambiguous.size
  p FontGenerator.cyrillic_ambiguous.size
  p FontGenerator.roman_number_ambiguous.size
  p FontGenerator.symbol_ambiguous.size
end
