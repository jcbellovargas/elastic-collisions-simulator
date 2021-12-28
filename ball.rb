require 'ruby2d'

class Ball
  attr_accessor :radius, :speed_x, :speed_y, :circle

  def initialize
    @radius = rand(5..30)
    initial_x = rand(@radius...Window.width-@radius)
    initial_y = rand(@radius...Window.height-@radius)
    @circle = Circle.new(
      x: initial_x, y: initial_y,
      radius: @radius,
      color: 'green'
    )

    @speed_x = rand(2)
    @speed_y = rand(2)
  end

  def x
    @circle.x
  end

  def y
    @circle.y
  end

  def color
    circle.color
  end

  def ==(other)
    x == other.x && y == other.y
  end




  def update_position
    @circle.x += @speed_x
    @circle.y += @speed_y
  end

end