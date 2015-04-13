require_relative 'fontforge'
require_relative 'find_fontfile'
require_relative 'east_asian_width'

module FontGenerator
  module_function

  def dejavu_sans_mono
    ff = FontForge.new

    ff.Open(q(find_fontfile("DejaVuSansMono.ttf")))
    ff.ScaleToEm(860, 140)
    ff.preprocess_for_merging

    ff.cmd("RoundToInt")
    ff.cmd("RemoveOverlap")
    ff.cmd("RoundToInt")
    ff.Save(q("run/DejaVuSansMono.sfd"))
    ff.Close

    return ff
  end
end

