require 'rails_helper'

RSpec.describe PostPolicy, type: :policy do
  subject { described_class.new(current_user, post) }

  let(:current_user) { create(:user) }

  describe '#destroy?' do
    context 'when postable User' do
      let(:post) { create(:post, :for_user) }

      context 'when user is admin' do
        let(:current_user) { create(:user, role: :admin) }

        it 'returns true' do
          expect(subject.destroy?).to be true
        end
      end

      context 'when current_user delete post on his page' do
        let(:post) { create(:post, postable: current_user) }

        it 'returns true' do
          expect(subject.destroy?).to be true
        end
      end

      context 'when current_user delete his post on other page' do
        let(:post) { create(:post, :for_user, creator: current_user) }

        it 'returns true' do
          expect(subject.destroy?).to be true
        end
      end

      context "when current_user tries to delete someone's other post on user page" do
        it 'returns false' do
          expect(subject.destroy?).to be false
        end
      end
    end

    context 'when postable Group' do
      let(:group) { create(:group) }
      let(:post) { create(:post, :for_group) }

      context 'when user is admin' do
        let(:current_user) { create(:user, role: :admin) }

        it 'returns true' do
          expect(subject.destroy?).to be true
        end
      end

      context 'when current_user is moderator of the group' do
        let(:post) { create(:post, :for_group, postable: group) }

        before { create(:user_group, user: current_user, group: group, moderator: true) }

        it 'returns true' do
          expect(subject.destroy?).to be true
        end
      end

      context 'when current_user is post creator' do
        let(:post) { create(:post, :for_group, creator: current_user) }

        it 'returns true' do
          expect(subject.destroy?).to be true
        end
      end

      context "when current_user tries to delete someone's other post on group page" do
        it 'returns false' do
          expect(subject.destroy?).to be false
        end
      end
    end
  end
end
