# == Schema Information
#
# Table name: stocks
#
#  id           :integer          not null, primary key
#  symbol       :string           not null
#  count        :integer          default(1), not null
#  portfolio_id :integer
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :stock do
    symbol 'MDL'
    count 1

    factory :another_stock do
      symbol 'AAPL'
      count 2
    end
  end
end
