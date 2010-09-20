libdir = File.dirname(__FILE__)
$:.unshift(libdir) unless $:.include?(libdir)

require 'texplay'
require 'panda_canvas/canvas'

module PandaCanvas

  class << self

    attr_reader :canvas

    def draw(width=640, height=480, &block)
      @canvas = Canvas.new(width, height, Fiber.new(&block))
      @canvas.show
    end

  end # class << self

end # PandaCanvas

def method_missing(sym, *args)
  found = false
  if PandaCanvas.canvas
    @panda_canvas_image ||= PandaCanvas.canvas.image
    if @panda_canvas_image.respond_to? sym
      @panda_canvas_image.send sym, *args
      found = true
    end
  end
  super(sym, *args) unless found
end