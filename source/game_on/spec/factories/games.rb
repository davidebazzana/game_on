FactoryBot.define do
  factory :game do
    title { "Pac-Man" }
    info { "Arcade" }
    category { "Adventure" }
    user_id { 1 }
  end
end
