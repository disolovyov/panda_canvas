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
      @canvas_calls = []
      @used_fonts = {}
    end

    # Draws the image in memory.
    def draw
      @image.draw(0, 0, 0)
      @canvas_calls.each {|call| send call[0], *call[1..-1] }
    end

    # Sets the font with name +font_name+ and +height+ in pixels to be used when drawing text.
    def font(font_name, height)
      key = [font_name, height]
      if @used_fonts.include? key
        @font = @used_fonts[key]
      else
        @font = @used_fonts[key] = Gosu::Font.new(self, font_name, height)
      end
    end

    # Returns a TexPlay predefined color for symbol +sym+.
    def sym_color(sym)
      rgb = TexPlay::Colors.const_get(sym.capitalize)[0..2].map! do |color|
        color * 255
      end
      Gosu::Color.new(255, *rgb)
    end

    # Draws text +s+ in coordinates +x+ and +y+ with a given +color+.
    def text(s, x, y, color)
      color = sym_color(color) if color.is_a? Symbol
      @font.draw(s, x, y, 0, 1, 1, color)
    end

    # Draws text +s+ in coordinates +x+ and +y+ with a given +color+.
    # Text is aligned using +rel_x+ and +rel_y+.
    # If the value of +rel_x+ is 0.0, the text will be to the right of +x+.
    # If it is 1.0, the text will be to the left of +x+.
    # If it is 0.5, it will be centered on +x+.
    # The same applies to +rel_y+.
    def text_rel(s, x, y, rel_x, rel_y, color)
      color = sym_color(color) if color.is_a? Symbol
      @font.draw_rel(s, x, y, 0, rel_x, rel_y, 1, 1, color)
    end

    # Runs a range of commands until the next flush.
    def update
      CleanRoom::CANVAS_UPDATE.each {|call| send call[0], *call[1..-1] }
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