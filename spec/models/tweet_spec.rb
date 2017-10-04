require 'rails_helper'

RSpec.describe Tweet, :type => :model do

  context "valid" do

    it "with attributes required" do
      subject.user =  User.create(email: "example@gmail.com", password: "123456")
      subject.description = "It's a Tweet"
      expect(subject).to be_valid
    end

  end

  context "invalid" do

    it "without an user" do
      expect(subject).to_not be_valid
    end

    it "without a description" do
      expect(subject).to_not be_valid
    end

  end
end