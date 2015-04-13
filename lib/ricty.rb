require_relative 'fontforge'
require_relative 'find_fontfile'

module FontGenerator
  module_function
  def ricty
    ascent = 835
    descent = 215
    panoseweight = 5
    fontweight = 400
    
    ff = FontForge.new
    ff.add(copyright)
    ff.New
    ff.Reencode(q("unicode"))
    ff.SetFontNames(q("RictyM-Regular"), q("RictyM"), q("RictyM Regular"), q("Regular"),
                    "copyright", q(version))
    
    ff.SetTTFName(0x409, 2, q("Regular"))
    ff.SetTTFName(0x409, 3, %Q["FontForge 2.0 : " + $fullname + " : " + Strftime("%d-%m-%Y", 0)])
    ff.ScaleToEm(860, 140)

    
    ff.SetOS2Value(q("Weight"), fontweight) # Book or Bold
    ff.SetOS2Value(q("Width"),                   5) # Medium
    ff.SetOS2Value(q("FSType"),                  0)
    ff.SetOS2Value(q("VendorID"),           q("PfEd"))
    ff.SetOS2Value(q("IBMFamily"),            2057) # SS Typewriter Gothic
    ff.SetOS2Value(q("WinAscentIsOffset"),       0)
    ff.SetOS2Value(q("WinDescentIsOffset"),      0)
    ff.SetOS2Value(q("TypoAscentIsOffset"),      0)
    ff.SetOS2Value(q("TypoDescentIsOffset"),     0)
    ff.SetOS2Value(q("HHeadAscentIsOffset"),     0)
    ff.SetOS2Value(q("HHeadDescentIsOffset"),    0)
    ff.SetOS2Value(q("WinAscent"),             ascent)
    ff.SetOS2Value(q("WinDescent"),            descent)
    ff.SetOS2Value(q("TypoAscent"),            860)
    ff.SetOS2Value(q("TypoDescent"),          -140)
    ff.SetOS2Value(q("TypoLineGap"),             0)
    ff.SetOS2Value(q("HHeadAscent"),           ascent)
    ff.SetOS2Value(q("HHeadDescent"),         -descent)
    ff.SetOS2Value(q("HHeadLineGap"),            0)
    ff.SetPanose([2, 11, panoseweight, 9, 2, 2, 3, 2, 2, 7])
    
    ff.MergeFonts(q("run/modified_inconsolata.sfd"))
    ff.MergeFonts(q("run/migu-1m.sfd"))

    # Zenkaku space
    ff.Select("0u2610"); ff.Copy(); ff.Select("0u3000"); ff.Paste()
    ff.Select("0u271a"); ff.Copy(); ff.Select("0u3000"); ff.PasteInto()
    ff.OverlapIntersect()
    # Edit zenkaku comma and period
    ff.Select("0uff0c"); ff.Scale(150, 150, 100, 0); ff.SetWidth(1000)
    ff.Select("0uff0e"); ff.Scale(150, 150, 100, 0); ff.SetWidth(1000)
    # Edit zenkaku colon and semicolon
    ff.Select("0uff0c"); ff.Copy(); ff.Select("0uff1b"); ff.Paste()
    ff.Select("0uff0e"); ff.Copy(); ff.Select("0uff1b"); ff.PasteWithOffset(0, 400)
    ff.CenterInWidth()
    ff.Select("0uff1a"); ff.Paste(); ff.PasteWithOffset(0, 400)
    ff.CenterInWidth()
    # Edit zenkaku brackets
    ff.Select("0u0028"); ff.Copy(); ff.Select("0uff08"); ff.Paste(); ff.Move(250, 0); ff.SetWidth(1000) # (
    ff.Select("0u0029"); ff.Copy(); ff.Select("0uff09"); ff.Paste(); ff.Move(250, 0); ff.SetWidth(1000) # )
    ff.Select("0u005b"); ff.Copy(); ff.Select("0uff3b"); ff.Paste(); ff.Move(250, 0); ff.SetWidth(1000) # [
    ff.Select("0u005d"); ff.Copy(); ff.Select("0uff3d"); ff.Paste(); ff.Move(250, 0); ff.SetWidth(1000) # ]
    ff.Select("0u007b"); ff.Copy(); ff.Select("0uff5b"); ff.Paste(); ff.Move(250, 0); ff.SetWidth(1000) # {
    ff.Select("0u007d"); ff.Copy(); ff.Select("0uff5d"); ff.Paste(); ff.Move(250, 0); ff.SetWidth(1000) # }
    ff.Select("0u003c"); ff.Copy(); ff.Select("0uff1c"); ff.Paste(); ff.Move(250, 0); ff.SetWidth(1000) # <
    ff.Select("0u003e"); ff.Copy(); ff.Select("0uff1e"); ff.Paste(); ff.Move(250, 0); ff.SetWidth(1000) # >
    # Edit en dash
    ff.Select("0u2013"); ff.Copy()
    ff.PasteWithOffset(200, 0); ff.PasteWithOffset(-200, 0)
    ff.OverlapIntersect()
    # Edit em dash
    ff.Select("0u2014"); ff.Copy()
    ff.PasteWithOffset(320, 0); ff.PasteWithOffset(-320, 0)
    ff.Select("0u007c"); ff.Copy(); ff.Select("0u2014"); ff.PasteInto()
    ff.OverlapIntersect()
    
    # Detach and remove .notdef
    ff.Select(q(".notdef"))
    ff.DetachAndRemoveGlyphs()
    # Post-proccess
    ff.SelectWorthOutputting()
    ff.RoundToInt(); ff.RemoveOverlap(); ff.RoundToInt()
    
    ff.Generate(q("RictyM-Regular.ttf"), q(""), 0x84)
    ff.Close
    return ff
  end

  # Return copyright string
  # This is needed because fontforge doesn't accept
  # "long" string.
  def copyright
<<'EOS'
copyright         = "Copyright (c) 2011-2014 Yasunori Yusa\n" \
                  + "Copyright (c) 2006 Raph Levien\n" \
                  + "Copyright (c) 2006-2013 itouhiro\n" \
                  + "Copyright (c) 2002-2013 M+ FONTS PROJECT\n" \
                  + "Copyright (c) 2003-2011 Information-technology Promotion Agency, Japan (IPA)\n" \
                  + "SIL Open Font License Version 1.1 (http://scripts.sil.org/ofl)\n" \
                  + "IPA Font License Agreement v1.0 (http://ipafont.ipa.go.jp/ipa_font_license_v1.html)"
EOS
  end

  def version
    "3.2.4+1"
  end
end

if __FILE__ == $0 
  FontGenerator.ricty.save("run/ricty.pe")
end
