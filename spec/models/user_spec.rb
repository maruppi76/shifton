require 'rails_helper'

RSpec.describe User, type: :model do
  before do
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

    context '異常' do
      it 'first_name:必須' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'first_name:全角（漢字・カタカナ・ひらがな）' do
        @user.first_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end

      it 'last_name:必須' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end

      it 'last_name:全角（漢字・カタカナ・ひらがな）' do
        @user.last_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end

      it 'first_name_kana:必須' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it 'first_name_kana:全角（カタカナ）' do
        @user.first_name_kana = 'てすと'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid')
      end

      it 'first_name_kana:全角（カタカナ）' do
        @user.first_name_kana = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid')
      end

      it 'last_name_kana:必須' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it 'last_name_kana:全角（カタカナ）' do
        @user.last_name_kana = 'てすと'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end

      it 'first_name_kana:全角（カタカナ）' do
        @user.last_name_kana = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end

      it 'email:必須' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'email:@を含む' do
        @user.email = 'testtest.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'email:一意性' do
        first_user = FactoryBot.create(:user, email: 'test@test.com')
        second_user = FactoryBot.build(:user, email: 'test@test.com')
        second_user.valid?
        expect(second_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'password:必須' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'password:6文字以上' do
        @user.password = 'aA1'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'password:半角英数混合(半角英語のみ)' do
        @user.password = 'aaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end

      it 'password:半角英数混合(数字のみ)' do
        @user.password = '1111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end

      it 'password:半角英数混合(全角英数混合)' do
        @user.password = 'ＡＡＡＡＡ１１'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end

      it 'role:必須' do
        @user.role = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Role can't be blank")
      end

      it 'status:必須' do
        @user.status = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Status can't be blank")
      end

      it 'admin:必須' do
        @user.admin = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Admin can't be blank")
      end
    end
  end
end
