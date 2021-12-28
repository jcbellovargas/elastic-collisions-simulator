require 'ruby2d'
class Ball
  def initialize
    @radius = rand(5..30)
    initial_x = rand(@radius...Window.width-@radius)
    initial_y = rand(@radius...Window.height-@radius)
    @circle = Circle.new(
      x: initial_x, y: initial_y,
      radius: @radius,
      color: 'random'
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

  def move!
    calculate_wall_collisions
    @circle.x += @speed_x
    @circle.y += @speed_y
  end

  def calculate_wall_collisions
    #right wall
    if (x + @radius) == Window.width
      @speed_x *= -1
    end
    # left wall
    if (x - @radius) == 0
      @speed_x *= -1
    end
    # upper wall
    if (y - @radius) == 0
      @speed_y *= -1
    end
    # bottom wall
    if (y + @radius) == Window.height
      @speed_y *= -1
    end
  end
end