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
        @shift.pattern.pattern_type = '休日'
        @shift.type = nil
        expect(@shift).to be_valid
      end
    end

    context '異常' do
      it 'user:必須' do
        @shift.user = nil
        @shift.valid?
        expect(@shift.errors.full_messages).to include('User must exist')
      end

      it 'pattern:必須' do
        @shift.pattern = nil
        @shift.valid?
        expect(@shift.errors.full_messages).to include('Pattern must exist')
      end

      it 'pattern_typeが出勤日のとき、typeは必須' do
        @shift.type = nil
        @shift.valid?
        expect(@shift.errors.full_messages).to include("Type can't be blank")
      end
    end
  end
end
