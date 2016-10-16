class CommentsController < ApplicationController
    before_action :set_post

    def index
        @comments = @post.comments.order("created_at ASC")

        respond_to do |format|
            format.html {render layout: !request.xhr? }
        end
    end

    def create
        @comment = Comment.create(comment_params)
        @comment.user_id = current_user.id
        @comment.post_id = @post.id

        if @comment.save
            create_notification @post, @comment
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
        @comment = @post.comments.find(params[:id])

        if @comment.user_id == current_user.id
            @comment.delete 
            respond_to do |format|
                format.html { redirect_to :back }
                format.js
            end
        end
    end

    private 

    def set_post
        @post = Post.find(params[:post_id])
    end

    def comment_params 
        params.require(:comment).permit(:content)
    end

    def create_notification(post, comment) 
        return if post.user.id == current_user.id
        Notification.create(user_id: post.user.id, notified_by: current_user.id, post_id: post.id, identifier: comment.id, notice_type: 'comment')
    end
    
end
