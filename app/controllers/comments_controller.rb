class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])

    @comment = @post.comments.create(comment_params)

    if @comment.errors.any?
      set_markdown
      render "posts/show"
    else
      redirect_to post_path(@post)
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:name, :body)
    end

    # Set up the markdown parser.
    # Required, as we will be rendering "posts/show".
    def set_markdown
      @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions = {})
    end
end
