libdir = File.dirname(__FILE__)
$:.unshift(libdir) unless $:.include?(libdir)

require 'texplay'
require 'panda_canvas/canvas'
require 'panda_canvas/clean_room'

module PandaCanvas

  class << self

    attr_reader :canvas

    def draw(width=640, height=480, &block)
      clean_room = CleanRoom.new
      clean_room.instance_eval(&block)
      @canvas = Canvas.new(width, height, clean_room.calls)
      @canvas.show
    end

  end # class << self

end # PandaCanvas

def method_missing(sym, *args)
  found = false
  if PandaCanvas.canvas
    @panda_canvas_image ||= PandaCanvas.canvas.image
    if @panda_canvas_image.respond_to? sym
      pci = @panda_canvas_image
      self.class.instance_eval do
        define_method(sym) {|*args| pci.send sym, *args }
      end
      self.send sym, *args
      found = true
    end
  end
  super(sym, *args) unless found
end