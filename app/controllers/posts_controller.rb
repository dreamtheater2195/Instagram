class PostsController < ApplicationController
    before_action :find_post, only: [:show, :edit, :destroy, :update, :like, :unlike]
    before_action :authenticate_user!
    before_action :owned_post, only: [:edit, :update, :destroy]

    def index
        @posts = Post.all.order("created_at DESC").page params[:page]
    end

    def new
        @post = current_user.posts.build
    end

    def create
        @post = current_user.posts.build(post_params)
        if @post.save
            flash[:success] = "Your post has been created!"
            redirect_to @post 
        else 
            flash.now[:alert] = "Your new post couldn't be created!  Please check the form."
            render 'new'
        end
    end 

    def show
        @comments = Comment.where(post_id: @post)
    end

    def edit
    end

    def update
        if @post.update(post_params)
            flash[:success] = "Post updated."
            redirect_to @post
        else
            flash.now[:alert] = "Update failed.  Please check the form."
            render 'edit'
        end
    end

    def destroy
        @post.destroy
        flash[:success] = "Your post has been deleted."
        redirect_to root_path
    end

    def like
        if @post.liked_by current_user
            respond_to do |format|
                format.html { redirect_to :back}
                format.js
            end
        end
    end

    def unlike
        if @post.unliked_by current_user
            respond_to do |format|
                format.html { redirect_to :back}
                format.js
            end
        end
    end

    private 
        def find_post
            @post = Post.find(params[:id])
        end
        
        def post_params
            params.require(:post).permit(:description,:image)
        end

        def owned_post
            unless current_user == @post.user
                flash[:alert] = "That post doesn't belong to you!"
                redirect_to root_path
            end 
        end
end
