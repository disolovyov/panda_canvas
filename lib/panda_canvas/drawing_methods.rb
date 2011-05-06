module PandaCanvas

  # DrawingMethods is a set of drawing methods used by PandaCanvas canvases.
  module DrawingMethods

    # Signature set for defaults that are executed in each update event.
    CANVAS_UPDATE = [[:font, 12]]

    # Names of calls that need to be sent directly to Canvas instead of the TexPlay image on draw.
    CANVAS_CALLS = [:font, :text, :text_rel].freeze

    # Sets the font with name +font_name+ and +height+ in pixels to be used when drawing text.
    # All subsequent text drawing calls will use the given font.
    def font(height, font_name=Gosu::default_font_name)
      @used_fonts ||= {}
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
    def text(s, x, y, color=0xffffffff)
      color = sym_color(color) if color.is_a? Symbol
      @font.draw(s, x, y, 0, 1, 1, color)
    end

    # Draws text +s+ in coordinates +x+ and +y+ with a given +color+.
    # Text is aligned using +rel_x+ and +rel_y+.
    # If the value of +rel_x+ is 0.0, the text will be to the right of +x+.
    # If it is 1.0, the text will be to the left of +x+.
    # If it is 0.5, it will be centered on +x+.
    # The same applies to +rel_y+.
    def text_rel(s, x, y, rel_x, rel_y, color=0xffffffff)
      color = sym_color(color) if color.is_a? Symbol
      @font.draw_rel(s, x, y, 0, rel_x, rel_y, 1, 1, color)
    end

  end # DrawingMethods

end # PandaCanvas
