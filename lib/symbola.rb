require_relative 'fontforge'
require_relative 'find_fontfile'
require_relative 'east_asian_width'

module FontGenerator
  module_function

  def symbola
    ff = FontForge.new

    ff.Open(q(find_fontfile("Symbola605.ttf")))
    ff.ScaleToEm(860, 140)
    ff.preprocess_for_merging

    symbol_ambiguous.each{|c| ff.half_nize(c, 70) }
    
    ff.cmd("RoundToInt")
    ff.cmd("RemoveOverlap")
    ff.cmd("RoundToInt")
    ff.Save(q("run/Symbola605.sfd"))
    ff.Close

    return ff
  end
end

