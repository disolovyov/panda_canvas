require 'texplay'

class PandaCanvas < Gosu::Window

  # Creates a new canvas window with dimensions +width+ and +height+.
  # A list of +commands+ of the form +[:method, [*args]]+ is passed to be executed.
  def initialize(width, height, commands)
    super(width, height, false)
    self.caption = 'Panda Canvas'
    @image = TexPlay.create_image(self, width, height)
    @commands = commands
  end

  # Runs a range of commands until the next flush.
  def update
    unless @commands.empty?
      @commands.slice!(0...@commands.index(FLUSH_SIGNATURE)).each do |command|
        @image.send command[0], *command[1]
      end
      @commands.shift
    end
  end

  # Draws the image in memory.
  def draw
    @image.draw(0, 0, 0)
  end

end # end PandaCanvas

__width__ = 640
__height__ = 480
__commands__ = []
IMAGE_METHODS = (Gosu::Image.public_instance_methods + [:flush]).freeze
FLUSH_SIGNATURE = [:flush, []].freeze

self.class.instance_eval do
  define_method(:method_missing) do |sym, *args|
    if IMAGE_METHODS.include? sym
      __commands__ << [sym, args]
    else
      super(sym, *args)
    end
  end
end

at_exit do
  __commands__ << FLUSH_SIGNATURE
  PandaCanvas.new(__width__, __height__, __commands__).show if $!.nil?
end