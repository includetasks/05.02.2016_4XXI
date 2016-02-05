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

require 'rails_helper'

RSpec.describe Stock, type: :model do
  let(:spec_stock) { create(:stock) }

  context 'is valid when' do
    it 'all fields has allowable values' do
      expect(spec_stock).to be_valid
    end
  end

  context 'is invalid when' do
    it '#symbol is not present' do
      spec_stock.symbol = ''
      expect(spec_stock).not_to be_valid
    end

    it '#count is less than 0' do
      spec_stock.count = -1
      expect(spec_stock).not_to be_valid
    end

    it '#count is not an integer' do
      spec_stock.count = 0.1
      expect(spec_stock).not_to be_valid

      spec_stock.count = 'x'
      expect(spec_stock).not_to be_valid
    end
  end

  it '#increase changes count to +1' do
    expect{ spec_stock.increase }.to change{ spec_stock.count }
  end

  it '#decrease changes count to -1' do
    expect{ spec_stock.decrease }.to change{ spec_stock.count }.by(-1)
  end

  describe 'associations' do
    it { should belong_to(:portfolio) }
    it { should belong_to(:user) }
  end
end
