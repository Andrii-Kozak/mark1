# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe '#index' do
    subject { get :index }

    it { is_expected.to be_successful }
  end
end
