require_relative 'find_fontfile'
require_relative 'fontforge'

module FontGenerator
  module_function
  def inconsolata
    ff = FontForge.new

    ff.Print(q("Start..."))
    ff.Open(q(find_fontfile("Inconsolata.otf")))
    ff.ScaleToEm(860, 140)
    ff.preprocess_for_merging
    ff.Save(q("run/modified_inconsolata.sfd"))
    ff.Close
    
    return ff
  end
end

if __FILE__ == $0
  FontGenerator.inconsolata.save("run/inconsolata.pe")
end
