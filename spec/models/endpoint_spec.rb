# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Endpoint, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:id) }
    subject { Endpoint.new(id: '12345', verb: 'GET', path: '/something', response: { code: 200 }) }
    it { should validate_uniqueness_of(:id).case_insensitive }

    it { should validate_presence_of(:verb) }
    it do
      should validate_inclusion_of(:verb)
        .in_array(%w[GET HEAD POST PUT DELETE CONNECT OPTIONS TRACE])
        .with_message('shoulda-matchers test string is not a valid HTTP verb')
    end

    it { should validate_presence_of(:path) }

    it { should validate_presence_of(:response) }
  end
end
