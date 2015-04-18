Fabricator(:product) do
  name {Faker::Lorem.words(3).join(" ")} 
  price {Faker::Number.number(3)}
  description {Faker::Lorem.sentence(Random.rand(10))}
  active {true}
end
