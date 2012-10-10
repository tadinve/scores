# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :inning do
    player_name "MyString"
    status "MyString"
    runs 1
    minutes 1
    balls 1
    fours 1
    sixes 1
    strike_rate 1.5
    match_id 1
  end
end
