class Admin::ZoomapsController < Admin::AdminMainController

  before_filter :require_administrator, :except=>[:index,:show]
  def index
    # pagination logic
	# count zoomaps
	zoomap_count = Zoomap.count
	
	@no_of_pages = (zoomap_count % 10)== 0 ? zoomap_count/10 : (zoomap_count/10) + 1
	
	@current_page = params[:page_no] ? params[:page_no].to_i : 1
	
	@sort_by = params[:sort_by] ? params[:sort_by] : "id"
	
	@zoomaps = Zoomap.find(:all, :offset =>(@current_page-1) * 10, :limit=> 10, :order=>"#{@sort_by}")
	
  end

  def show
    @zoomap = Zoomap.find(params[:id])
  end
  
  def new
    @zoomap = Zoomap.new
  end

  def create
    @zoomap = Zoomap.new(params[:zoomap])
    if @zoomap.save
      flash[:notice] = "Added new zoomap."
      redirect_to admin_zoomap_path(@zoomap)
    else
      flash[:notice] = "Failed saving new zoomap."
      render :action => "new"
    end

    
  end

  def edit
    @zoomap = Zoomap.find(params[:id])
  end

  def update
    @zoomap = Zoomap.find(params[:id])
    if @zoomap.update_attributes(params[:zoomap])
      flash[:notice] = "Updated zoomap."
      redirect_to admin_zoomap_path(@zoomap)
      
    else
      flash[:notice] = "Failed updating zoomap."
      render :action => "edit"
    end

  end

  def destroy
    @zoomap = Zoomap.find(params[:id])
    if @zoomap.destroy
      flash[:notice] = "Deleted zoomap."
      
    else
      flash[:notice] = "Failed deleting zoomap."
    end
    redirect_to admin_zoomaps_path
  end
  
  private
    def require_administrator
		unless session[:employee_type] == "Administrator"
			flash[:notice] = "Unauthorized access."
			redirect_to '/admin/management'
		end
	end
end

