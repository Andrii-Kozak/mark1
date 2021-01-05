require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { FactoryBot.build(:user, last_name: "Doe", first_name: "John") }

  context "when valid Factory" do
    it "has a valid factory" do
      expect(FactoryBot.build(:user)).to be_valid
    end
  end

  describe "#full_name" do
    it "returns full name" do
      expect(user.full_name).to eq("John Doe")
    end
  end

  describe "length is invalid" do
    it { is_expected.not_to allow_value("a" * 51).for(:first_name) }

    it { is_expected.not_to allow_value("a" * 51).for(:last_name) }

    it { is_expected.not_to allow_value("a" * 256).for(:email) }
  end

  describe "length is valid" do
    it { is_expected.to allow_value("a" * 49).for(:last_name) }

    it { is_expected.to allow_value("a" * 49).for(:first_name) }

    it { is_expected.to allow_value("#{'a' * 245}@gmail.com").for(:email) }
  end

  context "when email is valid" do
    it { is_expected.to allow_value('example@gmail.com').for(:email) }
  end

  context "when email is invalid" do
    it { is_expected.not_to allow_value('invali-email.com').for(:email) }
  end
end
