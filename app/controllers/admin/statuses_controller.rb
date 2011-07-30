class Admin::StatusesController < Admin::AdminMainController

  before_filter :require_zookeeper, :except=>[:index, :show]
  def index
    # pagination logic
	# count statuss
	status_count = Status.count
	
	@no_of_pages = (status_count % 10)== 0 ? status_count/10 : (status_count/10) + 1
	
	@current_page = params[:page_no] ? params[:page_no].to_i : 1
	
	@sort_by = params[:sort_by] ? params[:sort_by] : "id"
	
	@statuses = Status.find(:all, :offset =>(@current_page-1) * 10, :limit=> 10, :order=>"#{@sort_by}")
	
  end

  def show
    @status = Status.find(params[:id])
  end
  
  def new
    @status = Status.new
  end

  def create
    @status = Status.new(params[:status])
    if @status.save
      flash[:notice] = "Added new status."
      redirect_to admin_status_path(@status)
      
    else
      flash[:notice] = "Failed saving new status."
      render :action => "new"
    end
    
    
  end

  def edit
    @status = Status.find(params[:id])
  end

  def update
    @status = Status.find(params[:id])
    if @status.update_attributes(params[:status])
      flash[:notice] = "Updated status."
      redirect_to admin_status_path(@status)
      
    else
      flash[:notice] = "Failed updating status."
      render :action => "edit"
    end

  end

  def destroy
    @status = Status.find(params[:id])
    if @status.destroy
      flash[:notice] = "Deleted status."
      
    else
      flash[:notice] = "Failed deleting status."
    end
    redirect_to admin_statuses_path
  end
  
  private
    def require_zookeeper
		unless ["Zookeeper","Administrator"].include? session[:employee_type]
			flash[:notice] = "Unauthorized access."
			redirect_to '/admin/management'
		end
	end
end

