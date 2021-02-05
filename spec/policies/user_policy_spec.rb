require 'rails_helper'

RSpec.describe UserPolicy, type: :model do
  subject { described_class }

  let!(:admin) { create(:user, :admin) }
  let!(:simple) { create(:user) }
  let!(:record) { create(:user) }

  permissions :destroy?, :edit?, :update? do
    it "allows an admin" do
      expect(subject).to permit(admin, record)
    end

    it "not allows simple" do
      expect(subject).not_to permit(simple, record)
    end
  end
end
