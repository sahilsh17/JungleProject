require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it "should check if password and password_confirmation exists" do
      @user = User.create(name: "abhishek",email: "abhishek@gmail.com")
      expect(@user.errors.full_messages).to include("Password can't be blank")
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
  
    end
    it "should check if password and password_confirmation are same" do
      @user = User.create(name: "abhishek",password: "123",password_confirmation: "1234",email: "abhishek@gmail.com")
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it "should check if email entered has unique format" do
      @user = User.create(name: "abhishek",password: "123",password_confirmation: "123",email: "test")
      expect(@user.errors.full_messages).to include("Email is invalid")
    end
    it "should check if password entered has minimum length of 6 characters" do
      @user = User.create(name: "abhishek",password: "123",password_confirmation: "123",email: "test@test.com")
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end
end
