require 'texplay'

class PandaCanvas < Gosu::Window

  # Creates a new canvas window with dimensions +width+ and +height+.
  def initialize(width=640, height=480, &block)
    super(width, height, false)
    self.caption = 'Panda Canvas'
    @image = TexPlay.create_image(self, width, height)
    instance_eval(&block)
    @@commands << PAINT_SIGNATURE
  end

  # Runs a range of commands until the next flush.
  def update
    unless @@commands.empty?
      @@commands.slice!(0...@@commands.index(PAINT_SIGNATURE)).each do |command|
        @image.send command[0], *command[1]
      end
      @@commands.shift
    end
  end

  # Draws the image in memory.
  def draw
    @image.draw(0, 0, 0)
  end

  IMAGE_METHODS = (Gosu::Image.public_instance_methods + [:paint]).freeze
  PAINT_SIGNATURE = [:paint, []].freeze

  @@commands = []

  define_method(:method_missing) do |sym, *args|
    if IMAGE_METHODS.include? sym
      @@commands << [sym, args]
    else
      super(sym, *args)
    end
  end

end # end PandaCanvas