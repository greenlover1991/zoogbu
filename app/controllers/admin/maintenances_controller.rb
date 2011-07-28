class Admin::MaintenancesController < Admin::AdminMainController
  
  before_filter :require_zookeeper, :except=>[:index,:show]
  def index
    # pagination logic
	# count foods
	maintenance_count = Maintenance.count
	
	@no_of_pages = (maintenance_count % 10)== 0 ? maintenance_count/10 : (maintenance_count/10) + 1
	
	@current_page = params[:page_no] ? params[:page_no].to_i : 1
	
	@sort_by = params[:sort_by] ? params[:sort_by] : "id"
	
	redirect_to "/admin/maintenance/page/1/sort/#{@sort_by}" if params[:page_no].to_i > @no_of_pages
	
	@maintenances = Maintenance.find(:all, :offset =>(@current_page-1) * 10, :limit=> 10, :order=>"#{@sort_by}")
  end

  def show
    @maintenance = Maintenance.find(params[:id])
  end
  
  def new
    @maintenance = Maintenance.new
    
  end

  def create	
    @maintenance = Maintenance.new(params[:maintenance])

    if @maintenance.save
      flash[:notice] = "Added new maintenance."
      redirect_to admin_maintenance_path(@maintenance)
      
    else
      flash[:notice] = "Failed saving new maintenance."
      render :action => "new"
    end
    
    
  end

  def edit
    @maintenance = Maintenance.find(params[:id])
  end

  def update
    params[:maintenance][:employee_ids] ||= []
    params[:maintenance][:food_ids] ||= []
    @maintenance = Maintenance.find(params[:id])
    if @maintenance.update_attributes(params[:maintenance])
      flash[:notice] = "Updated maintenance."
      redirect_to admin_maintenance_path(@maintenance)
      
    else
      flash[:notice] = "Failed updating maintenance."
      render :action => "edit"
    end

  end

  def destroy
    @maintenance = Maintenance.find(params[:id])
    if @maintenance.destroy
      flash[:notice] = "Deleted maintenance."
      
    else
      flash[:notice] = "Failed deleting maintenance."
    end
    redirect_to admin_maintenances_path
  end
	
  private
    def require_zookeeper
		unless ["Zookeeper","Administrator"].include? session[:employee_type]
			flash[:notice] = "Unauthorized access."
			redirect_to '/admin/management'
		end
	end
  
end

