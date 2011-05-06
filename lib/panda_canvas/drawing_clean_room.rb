module PandaCanvas

  # DrawingCleanRoom is used to capture and store method calls for delayed execution.
  class DrawingCleanRoom

    # Signature for the +flush+ method.
    # This method is used to stop calculation and draw the frame.
    FLUSH = [:flush].freeze

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
      elsif (DrawingMethods::CANVAS_CALLS.include? sym) ||
        (Gosu::Image.public_instance_methods.include? sym)
        @_calls << [sym, *args]
      else
        super
      end
    end

  end # CleanRoom

end # PandaCanvas
