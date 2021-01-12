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
    it "should not allow to register if same email in different Case is entered" do
      @user1 = User.create(name: "abhishek",password: "1234567",password_confirmation: "1234567",email: "test@test.COM")
      @user2 = User.create(name: "abhishek",password: "123456",password_confirmation: "123456",email: "TEST@TEST.com")
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end
    it "should check if password entered has minimum length of 6 characters" do
      @user = User.create(name: "abhishek",password: "123",password_confirmation: "123",email: "test@test.com")
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
    
  end
  describe ".authenticate_with_credentials" do
    it "should authenticate with correct user credentials and return user object" do
      @user = User.create(name: 'John', email: 'john@example.com', password: 'password',password_confirmation: 'password')
      user = User.authenticate_with_credentials(@user.email, @user.password)
      expect(user.email).to eq('john@example.com')
    end
    it "should not authenticate if incorrect user credentials are used and return nil" do
      @user = User.create(name: 'John', email: 'john@example.com', password: 'password',password_confirmation: 'password')
      user = User.authenticate_with_credentials(@user.email, "pwd")
      expect(user).to eq(nil)
    end
    it "should authenticate successfully if user types spaces around email" do
      @user = User.create(name: 'John', email: 'john@example.com', password: 'password',password_confirmation: 'password')
      user = User.authenticate_with_credentials('john@example.com ', "password")
      expect(user).not_to eq(nil)   
    end
    it "should authenticate successfully if user types email with wrong case" do
      @user = User.create(name: 'John', email: 'johN@example.com', password: 'password',password_confirmation: 'password')
      user = User.authenticate_with_credentials('JOHn@EXAMPLE.COM ', "password")
      expect(user).not_to eq(nil)
    end
  end
end
