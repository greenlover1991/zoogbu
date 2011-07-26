class Admin::CommentsController < Admin::AdminMainController

  before_filter :require_administrator
  def index
	# pagination logic
	# count comments
	comment_count = Comment.count
	
	@no_of_pages = (comment_count % 10)== 0 ? comment_count/10 : (comment_count/10) + 1
	
	@current_page = params[:page_no] ? params[:page_no].to_i : 1
	
	@sort_by = params[:sort_by] ? params[:sort_by] : "status DESC"
	
	redirect_to "/admin/comment/page/1/sort/#{@sort_by}" if params[:page_no].to_i > @no_of_pages
	
	@comments = Comment.find(:all, :offset =>(@current_page-1) * 10, :limit=> 10, :order=>"#{@sort_by}")
	 
  end

  def show
    @comment = Comment.find(params[:id])
  end
  
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(params[:comment])
    if @comment.save
      flash[:notice] = "Added new comment."
      redirect_to admin_comment_path(@comment)
      
    else
      flash[:notice] = "Failed saving new comment."
      render :action => "new"
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(params[:comment])
      flash[:notice] = "Updated comment."
      redirect_to admin_comment_path(@comment)
     
    else
      flash[:notice] = "Failed updating comment."
      render :action => "edit"
    end

  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      flash[:notice] = "Deleted comment."
    else
      flash[:notice] = "Failed deleting comment."
    end
    redirect_to admin_comments_path
  end
  
  private
    def require_administrator
		unless session[:employee_type] == "Administrator" 
			flash[:notice] = "Unauthorized access."
			redirect_to '/admin/management'
		end
	end
end

