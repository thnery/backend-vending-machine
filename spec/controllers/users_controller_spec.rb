# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context 'when buyer deposit multiple of five' do
    let(:buyer) { create(:buyer_without_balance) }
    let(:jwt_token) { JwtHelper.encode({ username: buyer.username }, Rails.application.secrets.secret_key_base) }

    before(:each) do
      request.headers['Authorization'] = jwt_token
    end

    describe '#deposit' do
      it 'deposits 30' do
        post :deposit, params: { amount: 20 }
        json_response = JSON.parse(response.body)
        expect(json_response['current_balance']).to eq(20)

        post :deposit, params: { amount: 10 }
        json_response = JSON.parse(response.body)
        expect(json_response['current_balance']).to eq(30)
      end
    end
  end
end
