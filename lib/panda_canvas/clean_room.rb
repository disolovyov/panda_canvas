module PandaCanvas

  class CleanRoom

    FLUSH_SIGNATURE = [:flush].freeze

    def calls
      @calls + [FLUSH_SIGNATURE]
    end

    def initialize
      @calls = []
    end

    def method_missing(sym, *args)
      if sym == :flush
        @calls << FLUSH_SIGNATURE
      else
        @calls << [sym, *args]
      end
    end

  end # CleanRoom

end # PandaCanvas