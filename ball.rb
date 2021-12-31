require 'ruby2d'

class Ball
  attr_accessor :radius, :speed_x, :speed_y, :circle, :mass

  def initialize
    @radius = rand(20..35)
    @mass = @radius**2 # All balls have the same density
    initial_x = rand(@radius...Window.width-@radius)
    initial_y = rand(@radius...Window.height-@radius)
    @circle = Circle.new(
      x: initial_x, y: initial_y,
      radius: @radius,
      color: 'green'
    )

    @speed_x = rand(3)
    @speed_y = rand(3)
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

  def move
    @circle.x += @speed_x
    @circle.y += @speed_y
  end

  def update_position(x,y)
    @circle.x = x
    @circle.y = y
  end

  def update_speed(sx,sy)
    @speed_x = sx
    @speed_y = sy
  end

end