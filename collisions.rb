require 'ruby2d'
require 'pry'
require './ball'

set({ 
  title: "Elastic Collisions", 
  width: 800,
  height: 600,
  background: 'white'
})

@balls = []
15.times do
  @balls << Ball.new
end

def move_ball(ball)
  calculate_wall_collisions(ball)
  calculate_ball_collisions(ball)
  ball.move
end

def calculate_ball_collisions(current_ball)
  current_ball.circle.color = 'green'
  @balls.each do |ball|
    if balls_collide?(current_ball, ball) 
      current_ball.circle.color = 'red'
      collision_response(current_ball, ball)
    end
  end
end

def collision_response(b1, b2)
  fix_positions(b1,b2) if balls_overlap?(b1,b2)
  calculate_response(b1,b2)
end

def balls_overlap?(b1,b2)
  distance_between_points(b1,b2) < (b1.radius + b2.radius)
end

# This method takes care of separating both balls to the exact point of the collision. This is needed to fix cases in which the collision
# is detected when the balls have already overlaped
def fix_positions(b1,b2)
  distance_between_balls = distance_between_points(b1,b2)
  
  # m is the middle point between both balls centers
  mx = (b1.x + b2.x) / 2;
  my = (b1.y + b2.y) / 2;

  x1 = mx + b1.radius * (b1.x - b2.x) / distance_between_balls;
  y1 = my + b1.radius * (b1.y - b2.y) / distance_between_balls;

  x2 = mx + b2.radius * (b2.x - b1.x) / distance_between_balls;
  y2 = my + b2.radius * (b2.y - b1.y) / distance_between_balls;

  b1.update_position(x1,y1)
  b2.update_position(x2,y2)
end

def calculate_response(b1,b2)
  distance_between_balls = distance_between_points(b1,b2)

  # we need to normalize the vector which joins both ball's centers
  nx = (b2.x - b1.x) / distance_between_balls
  ny = (b2.y - b1.y) / distance_between_balls

  momentum = 2 * (b1.speed_x * nx + b1.speed_y * ny - b2.speed_x * nx - b2.speed_y * ny) / (b1.mass + b2.mass)

  sx1 = b1.speed_x - momentum * b1.mass * nx
  sy1 = b1.speed_y - momentum * b1.mass * ny
  sx2 = b2.speed_x + momentum * b2.mass * nx
  sy2 = b2.speed_y + momentum * b2.mass * ny

  b1.update_speed(sx1,sy1)
  b2.update_speed(sx2,sy2)
end

# Two balls collide if the distance between both centers is lower or equal the sum of their radiuses
def balls_collide?(b1, b2)
  return false unless b1 != b2

  distance_between_points(b1,b2) <= (b1.radius + b2.radius)
end

def distance_between_points(p1, p2)
  Math.sqrt((p2.x - p1.x)**2 + (p2.y - p1.y)**2)
end

def calculate_wall_collisions(ball)
  if (ball.x < ball.radius)
    ball.speed_x = ball.speed_x.abs
  end

  if (ball.y < ball.radius)
    ball.speed_y = ball.speed_y.abs
  end

  if (ball.x > Window.width - ball.radius)
    ball.speed_x *= -1
  end

  if (ball.y > Window.height - ball.radius)
    ball.speed_y *= -1
  end
end

# def calculate_wall_collisions(ball)
#   #right wall
#   if (ball.x + ball.radius) == Window.width
#     ball.speed_x *= -1
#   end
#   # left wall
#   if (ball.x - ball.radius) == 0
#     ball.speed_x *= -1
#   end
#   # upper wall
#   if (ball.y - ball.radius) == 0
#     ball.speed_y *= -1
#   end
#   # bottom wall
#   if (ball.y + ball.radius) == Window.height
#     ball.speed_y *= -1
#   end
# end


update do 
  @balls.each { |ball| move_ball(ball) }
end

show