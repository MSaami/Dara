require 'rails_helper'

RSpec.describe WalletTransaction, type: :model do
  describe 'association' do

    it {should belong_to(:category)}

  end
end
