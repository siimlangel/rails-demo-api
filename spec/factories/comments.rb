
FactoryBot.define do
    factory :comment do
        body {Faker::Lorem.sentence}
        post
    end
end
