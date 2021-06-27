require 'rails_helper'

RSpec.describe "Comments API", type: :request do
  let!(:post) { create(:post) }
  let!(:comments) { create_list(:comment, 20, post: post)}
  let(:post_id) { post.id }
  let(:id) {comments.first.id}


  describe 'GET /posts/:post_id/comments' do
    before { get "/posts/#{post_id}/comments" }

    context 'when post exists' do
      it 'returns status 200' do
        expect(response).to have_http_status(200)
      end
      
      it 'returns all post comments' do
        expect(json.size).to eq(20)
    end
  end

  context 'when post does not exist' do
    let(:post_id) {999}

    it 'returns status 404' do
      expect(response).to have_http_status(404)
    end
  end
end



  describe 'POST /posts/:post_id/comments/:id' do
    before {get "/posts/#{post_id}/comments/#{id}"}

    context 'when comment exists' do
      it 'returns status 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the comment' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when post comment does not exist' do
      let(:id) {1202}
      it 'returns status 404' do
        expect(response).to have_http_status(404)
      end
    end
  end



  describe 'PUT /posts/:post_id/comments/:id' do
    let(:valid_attributes) {{body: "Updated comment body"}}

    before { put "/posts/#{post_id}/comments/#{id}", params: valid_attributes}

    context 'when comment exists' do
      it 'returns status 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the comment' do
        updated_comment = Comment.find(id)
        expect(updated_comment.body).to match(/Updated comment body/)
      end
    end

    context 'when comment does not exist' do
      let(:id) {1202}

      it 'returns status 404' do
        expect(response).to have_http_status(404)
      end
    end
  end


  describe 'DELETE /posts/:post_id/comment/:id' do
    before {delete "/posts/#{post_id}/comments/#{id}"}

    it 'returns status 204' do 
      expect(response).to have_http_status(204)
    end
  end

end
