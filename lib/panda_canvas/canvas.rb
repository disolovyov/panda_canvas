module PandaCanvas

  class Canvas < Gosu::Window

    attr_reader :image

    def initialize(width, height, calls)
      super(width, height, false)
      self.caption = 'Panda Canvas'
      @image = TexPlay.create_image(self, width, height)
      @calls = calls
    end

    def draw
      @image.draw(0, 0, 0)
    end

    def update
      unless @calls.empty?
        @calls.slice!(0...@calls.index(CleanRoom::FLUSH_SIGNATURE)).each do |call|
          @image.send call[0], *call[1..-1]
        end
        @calls.shift
      end
    end

  end # Canvas

end # PandaCanvas