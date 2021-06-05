require 'rails_helper'

RSpec.describe Shift, type: :model do
  before do
    @shift = FactoryBot.build(:shift)
  end

  describe 'シフト新規作成' do
    context '正常' do
      it '全ての値が正常' do
        expect(@shift).to be_valid
      end

      it 'pattern_typeが出勤日以外のとき、typeは任意' do
        @shift.pattern.pattern_type = "休日"
        @shift.type = nil
        expect(@shift).to be_valid
      end
    end
  end
end