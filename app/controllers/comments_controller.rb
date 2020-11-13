class CommentsController < ApplicationController

    def create
        @comment = Comment.new(comment_params)
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
    end

    def destroy  
        @comment = Comment.find_by(id: params[:id])
        @comment.destroy
        session[:return_to] ||= request.referer
        redirect_to session.delete(:return_to)
    end

    private

    def comment_params
        params.require(:comment).permit(:content, :user_id, :commentable_type, :commentable_id)
    end

end
