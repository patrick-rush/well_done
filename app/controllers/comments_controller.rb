class CommentsController < ApplicationController

    def create
        @comment = Comment.new(comment_params)
        # binding.pry
        if @comment.commentable_type == "Task" && @comment.save
            flash[:success] = "Your comment has been added"
            redirect_to task_path(@comment.commentable_id)
        elsif @comment.commentable_type == "Project" && @comment.save
            flash[:success] = "Your comment has been added"
            redirect_to project_path(@comment.commentable_id)
        else
            flash[:error] = "Something went wrong! Please try again."
            session[:return_to] ||= request.referer
            redirect_to session.delete(:return_to)
        end


        # elsif @comment.task_id && @comment.save
        #     flash[:success] = "Your comment has been added"
        #     redirect_to task_path(@comment.task_id)
        # else
        #     flash[:error] = "Something went wrong! Please try again."
        #     session[:return_to] ||= request.referer
        #     redirect_to session.delete(:return_to)
        # end
    end

    private

    def comment_params
        params.require(:comment).permit(:content, :user_id, :commentable_type, :commentable_id)
    end

end
