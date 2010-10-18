module PandaCanvas

  # CleanRoom is used to capture and store method calls for delayed execution.
  class CleanRoom

    # Signature for the +flush+ method.
    # This method is used to stop calculation and draw the frame.
    FLUSH_SIGNATURE = [:flush].freeze

    # Returns an array of captured method calls.
    # A +flush+ is appended at the end.
    def calls
      @_calls + [FLUSH_SIGNATURE]
    end

    # Initializes the clean object for method call capturing.
    def initialize
      @_calls = []
    end

    # Capures and stores all missing method calls in the instance.
    def method_missing(sym, *args)
      if sym == :flush
        @_calls << FLUSH_SIGNATURE
      else
        @_calls << [sym, *args]
      end
    end

  end # CleanRoom

end # PandaCanvas