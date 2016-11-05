require "spec_helper"

describe PostsHelper do
  describe "#find_user_email" do
    let(:user) { User.new( email: 'user@gmail.com',password: 'shhhhh!') }
    it "returns an email" do
      user.save
      expect(helper.find_user_email(user.id)).to eq("user@gmail.com")
    end

    it "initiates a Twilio client" do
      client = helper.initiate_twilio_client
      expect(client).to be_an_instance_of(Twilio::REST::Client)
    end

    it "sends a text" do
      client = helper.initiate_twilio_client

      @number = '+12017350535' #enter your phone number here
      response = JSON.parse(helper.sent_text_to_user(client))
      expect(response).to be_an_instance_of(Hash)
    end
  end
end
