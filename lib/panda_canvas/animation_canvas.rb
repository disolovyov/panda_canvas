module PandaCanvas

  # AnimationCanvas is a subclassed Gosu::Window that is used for animation.
  class AnimationCanvas < Gosu::Window

    include DrawingMethods

    # TexPlay image, which is drawn in the window.
    attr_reader :image

    # Creates a new canvas window with dimensions +width+ and +height+.
    # A +block+ is passed to be executed.
    def initialize(width, height, &block)
      super(width, height, false)
      self.caption = 'Panda Canvas'
      @block = block
      @image = TexPlay.create_image(self, width, height)
      @agent = DrawingAgent.new(self, @image)
      @agent.frame = 0
    end

    # Draws the image in memory.
    def draw
      @image.draw(0, 0, 0)
      @agent.canvas_calls.each {|call| send call[0], *call[1..-1] }
    end

    # Runs an animation block.
    def update
      @image.rect 0, 0, width, height, :color => :black, :fill => true
      DrawingMethods::CANVAS_UPDATE.each {|call| send call[0], *call[1..-1] }
      @agent.canvas_calls = []
      @agent.frame += 1
      @agent.instance_eval &@block
    end

  end # AnimationCanvas

end # PandaCanvas
