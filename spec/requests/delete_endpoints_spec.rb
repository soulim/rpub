# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Endpoints', type: :request do
  describe 'DELETE /destroy' do
    context 'with valid parameters' do
      before do
        @endpoint_one = create(:endpoint, verb: 'GET', path: '/greeting', response: { code: 200 })
        @endpoint_two = create(:endpoint, verb: 'POST', path: '/greeting', response: { code: 200 })
      end

      it 'deletes endpoint object' do
        expect(@endpoint_one['id']).to eq('1')
        expect(@endpoint_one['verb']).to eq('GET')
        expect(@endpoint_one['path']).to eq('/greeting')

        expect(@endpoint_two['id']).to eq('2')
        expect(@endpoint_two['verb']).to eq('POST')
        expect(@endpoint_two['path']).to eq('/greeting')

        delete "/endpoints/#{@endpoint_one.id}"

        expect(response.status).to eq(204)
        expect(Endpoint.all.count).to eq 1
        expect(Endpoint.all[0]).to eq @endpoint_two
      end
    end

    context 'with invalid parameters' do
      it 'returns not found error' do
        endpoint = create(:endpoint, verb: 'GET', path: '/testing_greeting', response: { code: 200 })

        expect(endpoint['id']).to eq('1')
        expect(endpoint['verb']).to eq('GET')
        expect(endpoint['path']).to eq('/testing_greeting')

        delete "/endpoints/#{endpoint.id.to_i + 1}"

        expect(response.status).to eq(404)
        json = JSON.parse(response.body)
        expect(json['errors'][0]['code']).to eq('not_found')
        expect(json['errors'][0]['detail']).to eq('Requested Endpoint with ID `2` does not exist')
      end
    end
  end
end
