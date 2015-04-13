require 'find'

module FontGenerator
  FONT_DIRS = [
    "#{ENV["HOME"]}/.fonts", "/usr/local/share/fonts", "/usr/share/fonts",
  ]

  module_function
  def find_fontfile(target)
    FONT_DIRS.each do |dir|
      next if !Dir.exists?(dir)
      Find.find(dir){|path| return path if File.basename(path) == target }
    end
    return nil
  end
end

if __FILE__ == $0
  puts FontGenerator.find_fontfile("Inconsolata.otf")
  puts FontGenerator.find_fontfile("migu-1m-regular.ttf")
  puts FontGenerator.find_fontfile("migu-1m-bold.ttf")
end
