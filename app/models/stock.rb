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

class Stock < ActiveRecord::Base
  belongs_to :portfolio
  belongs_to :user

  validates :count, numericality: { only_integer: true,
                                    greater_than_or_equal_to: 0 }

  validates :symbol, presence: true

  def increase
    self.count += 1
  end

  def decrease
    self.count -= 1
  end
end
