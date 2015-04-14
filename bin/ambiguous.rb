require_relative '../lib/east_asian_width'

# prev = -1
# FontGenerator.east_asian_ambiguous_characters.each do |c|
#   puts(sprintf("%s%04x |%s|", (c-1 == prev) ? "|" : " ", c, c.chr("UTF-8")))
#   prev = c
# end

def print_char_info(code, trailing, comment)
  puts(sprintf("%s%04x |%s| %s", trailing ? "|" : " ", code, code.chr("UTF-8"), comment))
end

File.open("EastAsianWidth.txt") do |f|
  f.each_line do |line|
    next if /\A#/ =~ line

    if /\A([\dA-F]{4});A\s+(#.*)\Z/ =~ line
      print_char_info($1.to_i(16), false, $2)
    end

    if /\A([\dA-F]{4})\.\.([\dA-F]{4});A\s+(#.*)\Z/ =~ line
      from = $1.to_i(16); to = $2.to_i(16)
      print_char_info(from, false, $3)
      (from + 1 .. to).each{|c| print_char_info(c, true, "  |") }
    end
  end
end
