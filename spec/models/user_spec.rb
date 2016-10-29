require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Creating new user with valid info' do
    let(:user) { User.new( email: 'user@gmail.com',password: 'shhhhh!') }

    it 'save with email, password' do
      expect(user.save).to equal(true)
    end

    it 'is valid with email equal to "user@gmail.com"' do
      expect(user.email).to include("user@gmail.com")
    end

    it 'is valid with password equal to Hash String' do
      expect(user.password).to be_a_kind_of (String)
    end

    it 'is valid with the password "shhhhh!"' do
      expect(user.password).to eq ('shhhhh!')
    end

    it 'new user is an Object' do
        expect(user).to be_a_kind_of(Object)
    end
      it "DB has user@gmail.com as user" do
        user.save
        new_user = User.find_by(email: "user@gmail.com")
        expect(new_user.email).to eq("user@gmail.com")
      end

      it "DB changed by 1 when creating user" do
        expect{user.save}.to change(User,:count).by(1)
      end

      it "DB's last entry is user@gmail.com" do
        user.save
        last_user = User.last
        expect(last_user.email).to eq("user@gmail.com")
      end

    describe 'Testing for false positive' do

      it 'is not false when saving new user with valid info' do
        expect(user.save).to_not equal(false)
      end

      it 'password is not password1' do
        expect(user.password).to_not equal("password1")
      end

      it 'new user is not Aarry' do
        expect(user).to_not equal(Array)
      end

      it 'new user is not String' do
        expect(user).to_not equal(String)
      end

    end

  end

# ActiveRecord Tests
  describe 'ActiveRecord associations' do

    it 'users has_many posts' do
      expect(User.reflect_on_association(:posts).macro).to be (:has_many)
    end

    it 'users has workouts in plural_name' do
      expect(User.reflect_on_association(:posts).plural_name).to eq ("posts")
    end

    it 'users has_many replies' do
      expect(User.reflect_on_association(:replies).macro).to be (:has_many)
    end

    it 'users has replies in plural_name' do
      expect(User.reflect_on_association(:replies).plural_name).to eq ("replies")
    end


    describe 'Save data' do

      let(:user) {User.new}

      it 'is invalid when only email is present' do
        user.email = "user2@gmail.com"
        expect(user.save).to equal false
      end

      it 'is invalid when only password is present' do
        user.password = "password"
        expect(user.save).to equal false
      end

    end

  end

  it "is invalid without a password" do
    user = User.new(password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end

  it "is invalid without an email address" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid with a duplicate email address" do
    User.create(
      email: 'joe@joe.com',
      password: 'password')
    user = User.new(
      email: 'joe@joe.com',
      password: 'password')
    user.valid?
    expect(user.errors[:email]).to include('has already been taken')
  end

  it "returns a contact's email as a string" do
        user = User.new(email: 'joe@joe.com')
    expect(user.email).to be_a_kind_of(String)
  end

  it "returns a contact's password as a string" do
        user = User.new(password: 'password')
    expect(user.password).to be_a_kind_of(String)
  end

end
