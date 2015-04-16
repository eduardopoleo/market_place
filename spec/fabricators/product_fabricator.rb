Fabricator(:product) do
  name {Faker::Lorem.words(3).join(" ")} 
  price {Faker::Number.number(3)}
  active {true}
end
