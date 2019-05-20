require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should save a vaild user' do
      user = User.new(
        first_name: "Any First Name",
        last_name: "Any Last Name",
        email: "test@test.com",
        password: "AAAAA",
        password_confirmation: "AAAAA"
      )
      expect(user).to be_valid
    end

    it 'should have password and matching confirmation' do
      user = User.new(
        first_name: "Any First Name",
        last_name: "Any Last Name",
        email: "test@test.com",
        password: "AAAAA",
        password_confirmation: "AAAAB"
      )
      expect(user).to_not be_valid
    end

    it 'Emails must be unique and not case sensitive' do
      user = User.new(
        first_name: "Any First Name",
        last_name: "Any Last Name",
        email: "test@test.com",
        password: "AAAAA",
        password_confirmation: "AAAAA"
      )
      user.save

      user2 = User.new(
        first_name: "Kevin",
        last_name: "Smith",
        email: "test@test.COM",
        password: "AAAAAA",
        password_confirmation: "AAAAAA"
      )
      expect(user2).to_not be_valid
    end

    it 'is not valid without an email' do
      user = User.new(
        first_name: "Any First Name",
        last_name: "Any Last Name",
        email: nil,
        password: "AAAAA",
        password_confirmation: "AAAAA"
      )
      expect(user).to_not be_valid
    end

    it 'is not valid without a first name' do
      user = User.new(
        first_name: nil,
        last_name: "Any Last Name",
        email: "email@email.com",
        password: "AAAAA",
        password_confirmation: "AAAAA"
      )
      expect(user).to_not be_valid
    end

    it 'is not valid without a last name' do
      user = User.new(
        first_name: "Fistname",
        last_name: nil,
        email: "email@email.com",
        password: "AAAAA",
        password_confirmation: "AAAAA"
      )
      expect(user).to_not be_valid
    end

    it "is not valid with password that is less than it's minimum length (which is 5)" do
      user = User.new(
        first_name: "Fistname",
        last_name: "Lastname",
        email: "email@email.com",
        password: "AAAA",
        password_confirmation: "AAAA"
      )
      expect(user).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it "logs in when a user inputs correct password" do
      user = User.new(
        first_name: "Fist Name",
        last_name: "Last Name",
        email: "fistname1@gmail.com",
        password: "BBBBB",
        password_confirmation: "BBBBB"
      )
      user.save
      expect(User.authenticate_with_credentials("fistname1@gmail.com", "BBBBB").present?).to eq(true)
    end

    it "doesn't log in when a user inputs incorrect password" do
      user = User.new(
        first_name: "Fist Name",
        last_name: "Last Name",
        email: "fistname2@gmail.com",
        password: "BBBBB",
        password_confirmation: "BBBBB"
      )
      user.save
      expect(User.authenticate_with_credentials("fistname2@gmail.com", "BBBBA").present?).to eq(false)
    end

    it "logs in when a user types in a few spaces before and/or after their email" do
      user = User.new(
        first_name: "Fist Name",
        last_name: "Last Name",
        email: "fistname2@gmail.com",
        password: "BBBBB",
        password_confirmation: "BBBBB"
      )
      user.save
      expect(User.authenticate_with_credentials("  fistname2@gmail.com  ", "BBBBB").present?).to eq(true)
    end

    it "logs in when a user types in the wrong case for their email" do
      user = User.new(
        first_name: "Fist Name",
        last_name: "Last Name",
        email: "eXample@domain.COM",
        password: "BBBBB",
        password_confirmation: "BBBBB"
      )
      user.save
      expect(User.authenticate_with_credentials("EXAMPLe@DOMAIN.CoM", "BBBBB").present?).to eq(true)
    end
  end
end
