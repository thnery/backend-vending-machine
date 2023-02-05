# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  context 'when seller creates a product' do
    let(:guitar_seller) { create(:seller) }
    let(:bass_seller) { create(:seller) }
    let(:buyer) { create(:buyer_without_balance) }

    describe 'GET #index' do
      let(:jwt_token) { JwtHelper.encode({ username: buyer.username }, Rails.application.secrets.secret_key_base) }

      before(:each) do
        request.headers['Authorization'] = jwt_token
      end

      it '.index' do
        get :index

        expect(response).to be_successful
      end
    end

    describe 'POST #product' do
      let(:jwt_token) { JwtHelper.encode({ username: guitar_seller.username }, Rails.application.secrets.secret_key_base) }

      before(:each) do
        request.headers['Authorization'] = jwt_token
      end

      it '.create valid product' do
        post :create, params: { product_name: 'Guitar Fender Stratocaster American Special', amount_available: 5, cost: 1000 }

        expect(response).to be_successful
      end

      it '.create invalid product' do
        post :create, params: { product_name: 'Guitar Fender Stratocaster American Special', amount_available: 5 }

        expect(response.status).to be(422)
      end

      it '.create with cost 0' do
        post :create, params: { product_name: 'Guitar Fender Stratocaster American Special', amount_available: 5, cost: 99 }

        expect(response.status).to be(422)
      end
    end

    describe '#PUT products' do
      let(:jwt_token_guitar) { JwtHelper.encode({ username: guitar_seller.username }, Rails.application.secrets.secret_key_base) }
      let(:jwt_token_bass) { JwtHelper.encode({ username: bass_seller.username }, Rails.application.secrets.secret_key_base) }

      let(:product_guitar) { create(:guitar, seller_id: guitar_seller.id) }
      let(:product_bass) { create(:bass, seller_id: bass_seller.id) }

      before(:each) do
        request.headers['Authorization'] = jwt_token_guitar
      end

      context 'when guitar seller tries to update its own products' do
        it '.update' do
          put :update, params: { id: product_guitar.id, product_name: 'Guitar Fender Custom Shop Deluxe' }

          expect(response).to be_successful
        end
      end

      context 'when guitar seller tries to update bass seller products' do
        it '.update' do
          put :update, params: { id: product_bass.id, product_name: 'Bass Fender Custom Shop' }

          expect(response.status).to be(403)
        end
      end
    end

    describe '#DELETE products' do
      let(:jwt_token_guitar) { JwtHelper.encode({ username: guitar_seller.username }, Rails.application.secrets.secret_key_base) }

      let(:product_guitar) { create(:guitar, seller_id: guitar_seller.id) }
      let(:product_bass) { create(:bass, seller_id: bass_seller.id) }

      before(:each) do
        request.headers['Authorization'] = jwt_token_guitar
      end

      context 'when guitar seller tries to delete its own products' do
        it '.delete' do
          delete :destroy, params: { id: product_guitar.id }

          expect(response).to be_successful
        end
      end

      context 'when guitar seller tries to update bass seller products' do
        it '.delete' do
          delete :destroy, params: { id: product_bass.id }

          expect(response.status).to be(403)
        end
      end
    end
  end
end
