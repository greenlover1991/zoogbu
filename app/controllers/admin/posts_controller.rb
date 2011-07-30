class Admin::PostsController < Admin::AdminMainController

  before_filter :require_administrator
  def index
	# pagination logic
	# count posts
	post_count = Post.count
	
	@no_of_pages = (post_count % 10)== 0 ? post_count/10 : (post_count/10) + 1
	
	@current_page = params[:page_no] ? params[:page_no].to_i : 1
	
	@sort_by = params[:sort_by] ? params[:sort_by] : "id"
	
	@posts = Post.find(:all, :offset =>(@current_page-1) * 10, :limit=> 10, :order=>"#{@sort_by}")
	
  end

  def show
    @post = Post.find(params[:id])
  end
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])
    if @post.save
      flash[:notice] = "Added new post."
      redirect_to admin_post_path(@post)
      
    else
      flash[:notice] = "Failed saving new post."
      render :action => "new"
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      flash[:notice] = "Updated post."
      redirect_to admin_post_path(@post)
      
    else
      flash[:notice] = "Failed updating post."
      render :action => "edit"
    end

  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "Deleted post."
    else
      flash[:notice] = "Failed deleting post."
    end
    redirect_to admin_post_path
  end
  
  private
    def require_administrator
		unless session[:employee_type] == "Administrator" 
			flash[:notice] = "Unauthorized access."
			redirect_to '/admin/management'
		end
	end

end

