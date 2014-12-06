critic_attributes = [
  { name: "The Critic", publication: "The Simpsons crossover episode", agree: 6 },
  { name: "Reineer Wolfcastle", publication: "Maybe you are all", agree: 2, disagree: 10 }
  ]


critic_attributes.each do |attributes|
  Critic.create(attributes)
end
