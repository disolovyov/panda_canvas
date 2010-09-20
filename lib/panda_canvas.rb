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