module PandaCanvas

  # Canvas is a subclassed Gosu::Window that is used for drawing.
  class Canvas < Gosu::Window

    include DrawingMethods

    # TexPlay image, which is drawn in the window.
    attr_reader :image

    # Creates a new canvas window with dimensions +width+ and +height+.
    # A list of +calls+ in the form +[:method, *args]+ is passed to be executed.
    def initialize(width, height, calls)
      super(width, height, false)
      self.caption = 'Panda Canvas'
      @image = TexPlay.create_image(self, width, height)
      @calls = calls
      @canvas_calls = []
    end

    # Draws the image in memory.
    def draw
      @image.draw(0, 0, 0)
      @canvas_calls.each {|call| send call[0], *call[1..-1] }
    end

    # Runs a range of commands until the next flush.
    def update
      DrawingMethods::CANVAS_UPDATE.each {|call| send call[0], *call[1..-1] }
      unless @calls.empty?
        @calls.slice!(0...@calls.index(CleanRoom::FLUSH)).each do |call|
          if DrawingMethods::CANVAS_CALLS.include? call[0]
            @canvas_calls << call
          else
            @image.send call[0], *call[1..-1]
          end
        end
        @calls.shift
      end
    end

  end # Canvas

end # PandaCanvas