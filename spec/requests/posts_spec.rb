require 'rails_helper'

RSpec.describe 'Posts API', type: :request do
  # initialize test data
  let!(:posts) { create_list(:post, 10) }
  let(:post_id) { posts.first.id }

  # Test suite for GET /posts
  describe 'GET /posts' do
    # make HTTP get request before each example
    before { get '/posts' }

    it 'returns posts' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /posts/:id
  describe 'GET /posts/:id' do
    before { get "/posts/#{post_id}" }

    context 'when the record exists' do
      it 'returns the post' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(post_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:post_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  # Test suite for POST /posts
  describe 'POST /posts' do
    # valid payload
    let(:valid_attributes) { { title: 'My first post', body: 'This is my first post' } }

    context 'when the request is valid' do
      before { post '/posts', params: valid_attributes }

      it 'creates a post' do
        expect(json['title']).to eq('My first post')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/posts', params: { title: 'Something' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

    end
  end

  # Test suite for PUT /posts/:id
  describe 'PUT /posts/:id' do
    let(:valid_attributes) { { title: 'New title' } }

    context 'when the record exists' do
      before { put "/posts/#{post_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /posts/:id
  describe 'DELETE /posts/:id' do
    before { delete "/posts/#{post_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end