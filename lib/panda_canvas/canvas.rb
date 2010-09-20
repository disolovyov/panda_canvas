require 'texplay'
require 'fiber'

module PandaCanvas

  class Canvas < Gosu::Window

    attr_reader :image

    def initialize(width, height, fiber)
      super(width, height, false)
      self.caption = 'Panda Canvas'
      @image = TexPlay.create_image(self, width, height)
      @fiber = fiber
    end

    def draw
      @image.draw(0, 0, 0)
    end

    def update
      @fiber.resume if @fiber.alive?
    end

  end # Canvas

end # PandaCanvas