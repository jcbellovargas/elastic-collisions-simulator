require 'ruby2d'
require 'pry'
require './ball'

set({ 
  title: "Elastic Collisions", 
  width: 800,
  height: 600,
  background: 'white'
})

balls = []
20.times do
  balls << Ball.new
end

update do 
  balls.each(&:move!)
end

show