require 'rails_helper'

RSpec.describe "Api::V1::Categories", type: :request do
  describe 'POST /create' do
    it 'Creates a category' do
      params = attributes_for(:category)

      post '/api/v1/category', params: { category: params }

      expect(response).to have_http_status(204)
      expect(Category.last.name).to eq(params[:name])
    end

    it 'returns 422 if name is empty' do
      params = {name: ''}
      post '/api/v1/category', params: {category: params}
      expect(response).to have_http_status(422)
    end
  end

  describe 'PUT /update' do
    subject {create(:category)}
    it 'updates name of category' do
      params = {name: 'Sport'}

      put '/api/v1/category/' + subject.id.to_s, params: {category: params}
      expect(response).to have_http_status(204)
      expect(Category.find(subject.id).name).to eq('Sport')
    end

  end

  describe 'GET /index' do
    it 'returns all categories' do
      categories = create_list(:category, 15)
      get '/api/v1/category'
      expect(response).to have_http_status(200)
      expect(json['data'].count).to eq(15)
    end
  end
end
