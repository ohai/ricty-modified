
module FontGenerator
  class FontForge
    def initialize
      @output = "" 
    end
    
    attr_reader :output

    def add(string)
      @output << string
    end
    
    def cmd(command, *args)
      @output << "#{command}(#{args.map(&method(:quote)).join(",")})\n"
    end

    def quote(target)
      case target
      when QuotedString
        string = target.string.gsub(/\n/){"\\n"}
        "\"#{string}\""
      when Array
        "[" + target.map{|e| quote(e)}.join(",") + "]"
      else
        target
      end
    end

    def save(path)
      IO.write(path, @output)
    end

    def preprocess_for_merging
      SelectWorthOutputting()
      ClearInstrs()
      UnlinkReference()
    end

    def half_nize(code, scale_width)
      Select("0u%04x" % code)
      Scale(scale_width, 100)
      SetWidth(500)
      CenterInWidth()
    end
      
    ["Open", "ScaleToEm", "Print", "Select", "Clear", "SelectWorthOutputting", "Save","Close",
     "ClearInstrs", "UnlinkReference", "SetWidth", "Scale", "Move",
     "New", "Reencode", "SetFontNames", "SetTTFName", "SetOS2Value", "SetPanose",
     "MergeFonts", "Copy", "Paste", "PasteInto", "OverlapIntersect",
     "DetachAndRemoveGlyphs", "RoundToInt", "RemoveOverlap", "Generate", "PasteWithOffset",
     "CenterInWidth",
    ].each do |cmdname|
      define_method(cmdname) {|*args|
        cmd(cmdname, *args)
      }
    end
  end
  
  QuotedString = Struct.new(:string)

  module_function
  def q(string)
    QuotedString.new(string)
  end
end
