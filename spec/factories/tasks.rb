FactoryBot.define do
  factory :task do
    name {'テストを書く'}
    description {'Rspec&Capybara&FactoryBotを準備する'}
    # relationを書く(このuserはファクトリー名:userのこと)
    user
  end
end
