module PandaCanvas

  # DrawingCanvas is a subclassed Gosu::Window that is used for drawing.
  class DrawingCanvas < Gosu::Window

    include DrawingMethods
    include DrawingWithCleanRoom

    # TexPlay image, which is drawn in the window.
    attr_reader :image

    # Creates a new canvas window with dimensions +width+ and +height+.
    # A +block+ is passed to be executed.
    def initialize(width, height, &block)
      super(width, height, false)
      self.caption = 'Panda Canvas'
      @image = TexPlay.create_image(self, width, height)
      @canvas_calls = []
      prepare &block
    end

    # Draws the image in memory.
    def draw
      @image.draw(0, 0, 0)
      @canvas_calls.each {|call| send call[0], *call[1..-1] }
    end

  end # DrawingCanvas

end # PandaCanvas
