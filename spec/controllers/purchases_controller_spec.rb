# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PurchasesController, type: :controller do
  let(:seller) { create(:seller) }

  let(:bread) { create(:bread, seller_id: seller.id) }

  context 'when buyer has balance' do
    let(:buyer_with_balance) { create(:buyer_with_balance) }
    let(:jwt_token) { JwtHelper.encode({ username: buyer_with_balance.username }, Rails.application.secrets.secret_key_base) }

    before(:each) do
      request.headers['Authorization'] = jwt_token
    end

    describe 'POST #buy' do
      let(:deposit) { buyer_with_balance.deposit }

      it 'returns a success response' do
        post :buy, params: { product_id: bread.id, amount_of_products: 4 }
        expect(response).to be_successful

        json_response = JSON.parse(response.body)

        expect(json_response['data']['spent']).to be(bread.cost * 4)
        expect(json_response['data']['change']).to eq([100]) # in this case, 100 is the minimum coins
      end
    end
  end

  context 'when buyer has no balance' do
    let(:buyer_without_balance) { create(:buyer_without_balance) }
    let(:jwt_token) { JwtHelper.encode({ username: buyer_without_balance.username }, Rails.application.secrets.secret_key_base) }

    before(:each) do
      request.headers['Authorization'] = jwt_token
    end

    describe 'POST #buy' do
      let(:deposit) { buyer_without_balance.deposit }

      it 'returns a success response' do
        post :buy, params: { product_id: bread.id, amount_of_products: 4 }
        expect(response.status).to be(422)
      end
    end
  end

  context 'when there are not enough products' do

  end
end
