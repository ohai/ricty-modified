require_relative 'fontforge'
require_relative 'find_fontfile'
require_relative 'east_asian_width'

module FontGenerator
  module_function

  def migu1m
    ff = FontForge.new

    ff.Open(q(find_fontfile("migu-1m-regular.ttf")))
    ff.ScaleToEm(860, 140)
    ff.preprocess_for_merging

    # scaling donw
    ff.SetWidth(-1, 1);
    ff.Scale(91, 91, 0, 0);
    ff.SetWidth(110, 2);
    ff.SetWidth(1, 1)
    ff.Move(23, 0)
    ff.SetWidth(-23, 1)

    # greek small alpha: 0x03B1
    # ff.Select("0u03b1")
    # ff.Scale(70, 100)
    # ff.SetWidth(500)
    # ff.CenterInWidth
    # east_asian_ambiguous_characters.each do |n|
    #   ff.Select("0u%04x" % n)
    #   ff.Scale(70, 100)
    #   ff.SetWidth(500)
    #   ff.CenterInWidth
    # end
    greek_ambiguous.each{|c| ff.half_nize(c, 80) }
    cyrillic_ambiguous.each{|c| ff.half_nize(c, 80) }
    roman_number_ambiguous.each{|c| ff.half_nize(c, 70) }
    symbol_ambiguous.each{|c| ff.half_nize(c, 70) }
    ff.half_nize(0x2202, 80) # partial differential
    
    ff.cmd("RoundToInt")
    ff.cmd("RemoveOverlap")
    ff.cmd("RoundToInt")
    ff.Save(q("run/migu-1m.sfd"))
    ff.Close
    
    return ff
  end
end

if __FILE__ == $0
  FontGenerator.migu1m.save("run/migu1m.pe")
end
