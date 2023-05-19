require 'rails_helper'

RSpec.describe "Api::V1::WalletTransactions", type: :request do

  describe 'POST /create' do
    it 'creates wallet transaction' do
      wallet = create(:wallet)
      params = build(:wallet_transaction, wallet: wallet).attributes
      post "/api/v1/wallet/#{params['wallet_id']}/wallet_transaction", params: {wallet_transaction: params}
      expect(response).to have_http_status(204)
      expect(WalletTransaction.count).to eq(1)
      expect(WalletTransaction.last.wallet.balance).to eq(wallet.balance + params['amount'])
    end
  end

  describe 'PUT /update' do
    it 'updates wallet transaction' do
      wallet_transaction = create(:wallet_transaction, amount: -1000)
      params = wallet_transaction.attributes
      params['amount'] = -500

      put "/api/v1/wallet_transaction/#{wallet_transaction.id}", params: {wallet_transaction: params}

      expect(response).to have_http_status(204)
      expect(wallet_transaction.reload.amount).to eq(-500)
    end

    it 'updates wallet balance if amount is changed' do
      wallet = create(:wallet, balance: 2000)
      wallet_transaction = create(:wallet_transaction, amount: -1000, wallet: wallet)
      params = wallet_transaction.attributes
      params['amount'] = -500
      put "/api/v1/wallet_transaction/#{wallet_transaction.id}", params: {wallet_transaction: params}
      expect(wallet.reload.balance).to eq(1500)
    end

    describe 'GET /index' do
      it 'display all of the transaction of wallet' do
        wallet = create(:wallet)
        wallet_transactions = create_list(:wallet_transaction, 15, wallet: wallet)
        get "/api/v1/wallet/#{wallet.id}/wallet_transaction"
        expect(response).to have_http_status(200)
        expect(json['data'].count).to eq(15)
      end
    end

    describe 'GET /show' do
      it 'returns a transaction' do
        wallet_transaction = create(:wallet_transaction)
        get "/api/v1/wallet_transaction/#{wallet_transaction.id}"
        expect(response).to have_http_status(200)
        body = JSON.parse(response.body)
        expect(body['data']['id']).to eq(wallet_transaction.id)




      end
    end
  end
end
