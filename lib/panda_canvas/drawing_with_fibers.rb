module PandaCanvas

  # DrawingWithFibers adds behavior to perform canvas updates
  # using fibers. Test show that this behavior is only suitable for unixes.
  module DrawingWithFibers

    # Yields control back to calling context.
    def flush
      Fiber.yield
    end

    # Creates a new fiber that evaluates the given +block+ in this instance.
    def prepare(&block)
      @agent = agent = DrawingAgent.new(self, @image)
      @fiber = Fiber.new { agent.instance_eval &block }
    end

    # Performs drawing until the next flush by resuming the fiber.
    def update
      if @fiber.alive?
        @agent.canvas_calls = []
        DrawingMethods::CANVAS_UPDATE.each {|call| send call[0], *call[1..-1] }
        @fiber.resume
        @canvas_calls = @agent.canvas_calls
      end
    end

  end # DrawingWithCleanRoom

end # PandaCanvas
