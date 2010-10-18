module PandaCanvas

  # CleanRoom is used to capture and store method calls for delayed execution.
  class CleanRoom

    # Signature for the +flush+ method.
    # This method is used to stop calculation and draw the frame.
    FLUSH = [:flush].freeze

    # Signature set for defaults that are executed in each update event.
    CANVAS_UPDATE = [[:font, Gosu::default_font_name, 12]]

    # Names of calls that need to be sent directly to Canvas instead of the TexPlay image on draw.
    CANVAS_CALLS = [:font, :text, :text_rel].freeze

    # Returns an array of captured method calls.
    # A +flush+ is appended at the end.
    def calls
      @_calls + [FLUSH]
    end

    # Initializes the clean object for method call capturing.
    def initialize
      @_calls = []
    end

    # Capures and stores all missing method calls in the instance.
    def method_missing(sym, *args)
      if sym == :flush
        @_calls << FLUSH
      else
        @_calls << [sym, *args]
      end
    end

    # Adds a font change call to +font_name+ with +height+ in pixels.
    # Uses default typeface, if +font_name+ is +nil+.
    # All subsequent text drawing calls will use the given font.
    def font(height, font_name=nil)
      @_calls << [:font, font_name || Gosu::default_font_name, height]
    end

    # Adds text +s+ to be drawn on screen with current font and +color+.
    # Text is placed in +x+ and +y+ coordinates.
    def text(s, x, y, color=0xffffffff)
      @_calls << [:text, s, x, y, color]
    end

  end # CleanRoom

end # PandaCanvas