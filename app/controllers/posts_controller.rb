class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:edit, :update, :destroy, :ship, :unship]

  def index
    @posts = current_user.posts.order(created_at: :desc)
  end

  def new
    @post = current_user.posts.new(
      day_of_week: params[:day_of_week] || 'monday',
      status: 'draft'
    )
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.status ||= 'draft'
    
    if @post.save
      redirect_to dashboard_path, notice: 'Post created successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to dashboard_path, notice: 'Post updated successfully.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to dashboard_path, notice: 'Post deleted successfully.'
  end

  def ship
    if @post.ship!
      redirect_to dashboard_path, notice: 'Post shipped! 🚀'
    else
      redirect_to dashboard_path, alert: 'Could not ship post.'
    end
  end

  def unship
    if @post.unship!
      redirect_to dashboard_path, notice: 'Post moved back to draft.'
    else
      redirect_to dashboard_path, alert: 'Could not unship post.'
    end
  end

  private

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :post_type, :day_of_week, :status, :platform, :tag_list)
  end
end
