class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_post_comment, only: [:show, :update, :destroy]


  # GET /comments
  def index
    render json: @post.comments
  end

  # GET /comments/1
  def show
    render json: @comment
  end

  # POST /comments
  def create
    @post.comments.create!(comment_params)
    render json: @post, status: :created
  end

  # PATCH/PUT /comments/1
  def update
    @comment.update(comment_params)
    head :no_content
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
    head :no_content
  end

  private

    def set_post
      @post = Post.find(params[:post_id])
    end

    def set_post_comment
      @comment = @post.comments.find_by!(id: params[:id]) if @post
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.permit(:body)
    end
end
