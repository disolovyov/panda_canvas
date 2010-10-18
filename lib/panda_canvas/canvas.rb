module PandaCanvas

  # Canvas is a subclassed Gosu::Window that is used for drawing.
  class Canvas < Gosu::Window

    # TexPlay image, which is drawn in the window.
    attr_reader :image

    # Creates a new canvas window with dimensions +width+ and +height+.
    # A list of +calls+ in the form +[:method, *args]+ is passed to be executed.
    def initialize(width, height, calls)
      super(width, height, false)
      self.caption = 'Panda Canvas'
      @image = TexPlay.create_image(self, width, height)
      @calls = calls
    end

    # Draws the image in memory.
    def draw
      @image.draw(0, 0, 0)
    end

    # Runs a range of commands until the next flush.
    def update
      unless @calls.empty?
        @calls.slice!(0...@calls.index(CleanRoom::FLUSH)).each do |call|
          @image.send call[0], *call[1..-1]
        end
        @calls.shift
      end
    end

  end # Canvas

end # PandaCanvas