# == Schema Information
#
# Table name: portfolios
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :portfolio do
    title 'Portfolio sample'
  end
end
