module PandaCanvas

  # DrawingAgent is used to capture drawing method calls
  # and pass them to the active window and a TextPlay image
  # in the correct order.
  class DrawingAgent

    # Array of methods that need to be passed to canvas.
    attr_accessor :canvas_calls

    # Current frame number.
    attr_accessor :frame

    # Initializes the clean object in a given +window+
    # for method call capturing.
    # TexPlay +image+ is used for TexPlay drawing methods.
    def initialize(window, image)
      @canvas_calls = []
      @window = window
      @image = image
    end

    # Capures and stores all missing method calls in the instance.
    def method_missing(sym, *args)
      if DrawingMethods::CANVAS_CALLS.include? sym
        @canvas_calls << [sym, *args]
      elsif Gosu::Image.public_instance_methods.include? sym
        @image.send sym, *args
      elsif @window.respond_to? sym
        @window.send sym, *args
      else
        super
      end
    end

  end # DrawingAgent

end # PandaCanvas
