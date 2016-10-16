class CommentsController < ApplicationController

    def index
        @post = Post.find(params[:post_id])
        @comments = @post.comments.order("created_at ASC")

        respond_to do |format|
            format.html {render layout: !request.xhr? }
        end
    end

    def create
        
        @post = Post.find(params[:post_id])
        @comment = Comment.create(params[:comment].permit(:content))
        @comment.user_id = current_user.id
        @comment.post_id = @post.id

        if @comment.save
            respond_to do |format|
                format.html { redirect_to :back }
                format.js
            end
        else
            flash[:alert] = "Check the comment form, something went wrong."
            render 'new'
        end
    end

    def destroy
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])

        if @comment.user_id == current_user.id
            @comment.delete 
            respond_to do |format|
                format.html { redirect_to :back }
                format.js
            end
        end
    end
end
