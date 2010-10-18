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
      @canvas_calls = CleanRoom::CANVAS_DEFAULTS
    end

    # Draws the image in memory.
    def draw
      @image.draw(0, 0, 0)
      @canvas_calls.each {|call| send call[0], *call[1..-1] }
    end

    # Sets the font with name +font_name+ and +height+ in pixels to be used when drawing text.
    def font(font_name, height)
      @font = Gosu::Font.new(self, font_name, height)
    end

    # Draws text +s+ in coordinates +x+ and +y+ with a given +color+.
    def text(s, x, y, color)
      @font.draw(s, x, y, 0, 1, 1, color)
    end

    # Runs a range of commands until the next flush.
    def update
      unless @calls.empty?
        @calls.slice!(0...@calls.index(CleanRoom::FLUSH)).each do |call|
          if CleanRoom::CANVAS_CALLS.include? call[0]
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