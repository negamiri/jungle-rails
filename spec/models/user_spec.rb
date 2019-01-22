require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do 
    @user = User.new(
      first_name: 'first',
      last_name: 'last',
      email: 'test@test.com',
      password: 'somepassword',
      password_confirmation: 'somepassword'
    )
  end

  describe 'Validations' do
    it "is valid with valid fields" do
      expect(@user).to be_valid
    end

    it "is not valid with no first name" do
      @user.first_name = nil
      expect(@user).to_not be_valid
    end

    it "is not valid with no last name" do
      @user.last_name = nil
      expect(@user).to_not be_valid
    end

    it "is not valid with no email given" do
      @user.email = nil
      expect(@user).to_not be_valid
    end

    it "is not valid when passwords do not match" do
      @user.password_confirmation = 'incorrect'
      expect(@user).to_not be_valid
    end

    it "is not valid when no password given" do
      @user.password = nil
      @user.password_confirmation = nil
      expect(@user).to_not be_valid
    end

    it "is not valid when new user has same email" do
      @user.save!
      user2 = User.new(
        first_name: 'first',
        last_name: 'last',
        email: 'TEST@TEST.COM',
        password: 'somepassword',
        password_confirmation: 'somepassword'
      )
      user2.save
      expect(user2).to_not be_valid
    end

    it "is not valid when password is less than 5 characters" do
      @user.password = 'none'
      @user.password_confirmation = 'none'
      expect(@user).to_not be_valid
    end

  end

  describe '.authenticate_with_credentials' do
    it "is valid with correct credentials" do
      @user.save
      expect(User.authenticate_with_credentials(@user.email, @user.password)).to_not eq(nil)
    end

    it "is valid with an email upper case" do
      @user.save
      expect(User.authenticate_with_credentials('TEST@TEST.COM', @user.password)).to_not eq(nil)
    end

    it "is not valid with an incorrect password" do
      @user.save
      expect(User.authenticate_with_credentials(@user.email, '1234567')).to be_falsey
    end

  end

end
