# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :score_content do
    title "MyText"
    team1 "MyString"
    team2 "MyString"
    match_status "MyText"
    runrates "MyText"
  end
end
