module Authors
  class PostsController < AuthorsController
    before_action :set_post, only: [:edit, :update, :destroy]

    # GET /posts
    # aqui ele vai mostrar somente os posts do usuario que criou
    def index
      @posts = current_author.posts
    end

    # GET /posts/new
    # aqui ele vai atribuir a criacao do post ao usuario que esta logado
    def new
      @post = current_author.posts.build
    end

    # GET /posts/1/edit
    def edit
      @paragraph = @post.elements.build(element_type: 'paragraph')
    end

    # POST /posts
    # aqui ele vai atribuir o posto ao usuario logado
    def create
      @post = current_author.posts.build(post_params)

      if @post.save
        redirect_to @post, notice: 'Post was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /posts/1
    def update
      if @post.update(post_params)
        redirect_to @post, notice: 'Post was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /posts/1
    def destroy
      @post.destroy
      redirect_to posts_url, notice: 'Post was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      # aqui ele vai pegar somente os postos criados pelo usuario
      def set_post
        @post = current_author.posts.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def post_params
        params.require(:post).permit(:title, :description)
      end
  end
end