require "spec_helper"

describe PostsHelper do
  describe "#find_user_email" do
    let(:user) { User.new( email: 'user@gmail.com',password: 'shhhhh!') }
    it "returns an email" do
      user.save
      helper.find_user_email(user.id).should eq("user@gmail.com")
    end
  end
end
