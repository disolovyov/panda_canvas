require_relative '../lib/panda_canvas'

PandaCanvas.draw do

  def frac(x1, y1, x2, y2)
    @lines ||= 0
    if ((x1 - x2) ** 2 + (y1 - y2) ** 2) < 3
      line x1, y1, x2, y2, :color => [x1 / 640.0, y1 / 480.0, 0.6]
      if (@lines += 1) == 500
        flush
        @lines = 0
      end
    else
      xt = (x1 + x2 + y1 - y2) / 2
      yt = (x2 - x1 + y1 + y2) / 2
      frac(x1, y1, xt, yt)
      frac(x2, y2, xt, yt)
    end
  end

  frac(150.0, 160.0, 540.0, 160.0)

end