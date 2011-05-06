module PandaCanvas

  # DrawingWithCleanRoom adds behavior to perform canvas updates
  # using method capturing and delayed execution.
  # This is faster, but somewhat ugly and should only be used in environments
  # where resuming fibers in the Gosu draw loop results in a segfault.
  module DrawingWithCleanRoom

    # Evaluates the drawing block in a DrawingCleanRoom instance
    # and captures drawing method sequence.
    def prepare(&block)
      clean_room = DrawingCleanRoom.new
      clean_room.instance_eval(&block)
      @calls = clean_room.calls
    end

    # Performs drawing until the next flush using the captured sequence.
    def update
      unless @calls.empty?
        DrawingMethods::CANVAS_UPDATE.each {|call| send call[0], *call[1..-1] }
        flush_index = @calls.index(DrawingCleanRoom::FLUSH)
        @calls.slice!(0...flush_index).each do |call|
          if DrawingMethods::CANVAS_CALLS.include? call[0]
            @canvas_calls << call
          else
            @image.send call[0], *call[1..-1]
          end
        end
        @calls.shift
      end
    end

  end # DrawingWithCleanRoom

end # PandaCanvas
