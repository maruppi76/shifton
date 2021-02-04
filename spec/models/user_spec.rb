require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    FactoryBot.build(:department)
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規作成' do
    context '正常' do
      it '全て正常' do
        expect(@user.valid?).to eq true
      end

      it 'staff_code:任意' do
        @user.staff_code = nil
        expect(@user.valid?).to eq true
      end

      it 'department_sub_id:任意' do
        @user.department_sub_id = nil
        expect(@user.valid?).to eq true
      end
    end
  end
end
