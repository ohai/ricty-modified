
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
end

if __FILE__ == $0
  p FontGenerator.east_asian_ambiguous_characters.map{|n| n.to_s(16) }.size
end
