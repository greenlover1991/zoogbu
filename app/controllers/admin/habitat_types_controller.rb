class Admin::HabitatTypesController < Admin::AdminMainController

  before_filter :require_administrator, :except=>[:index,:show]
  def index
    # pagination logic
	# count habitat_types
	habitat_type_count = HabitatType.count
	
	@no_of_pages = (habitat_type_count % 10)== 0 ? habitat_type_count/10 : (habitat_type_count/10) + 1
	
	@current_page = params[:page_no] ? params[:page_no].to_i : 1
	
	@sort_by = params[:sort_by] ? params[:sort_by] : "id"
	
	redirect_to "/admin/habitat_type/page/1/sort/#{@sort_by}" if params[:page_no].to_i > @no_of_pages
	
	@habitat_types = HabitatType.find(:all, :offset =>(@current_page-1) * 10, :limit=> 10, :order=>"#{@sort_by}")
  end

  def show
    @habitat_type = HabitatType.find(params[:id])
  end
  
  def new
    @habitat_type = HabitatType.new
  end

  def create
    @habitat_type = HabitatType.new(params[:habitat_type])
    if @habitat_type.save
      flash[:notice] = "Added new habitat type."
      redirect_to admin_habitat_type_path(@habitat_type)
      
    else
      flash[:notice] = "Failed saving new habitat type."
      render :action => "new"
    end
    
    
  end

  def edit
    @habitat_type = HabitatType.find(params[:id])
  end

  def update
    @habitat_type = HabitatType.find(params[:id])
    if @habitat_type.update_attributes(params[:habitat_type])
      flash[:notice] = "Updated habitat type."
      redirect_to admin_habitat_type_path(@habitat_type)
      
    else
      flash[:notice] = "Failed updating habitat type."
      render :action => "edit"
    end

  end

  def destroy
    @habitat_type = HabitatType.find(params[:id])
    if @habitat_type.destroy
      flash[:notice] = "Deleted habitat type."
      
    else
      flash[:notice] = "Failed deleting habitat type."
    end
    redirect_to admin_habitat_types_path
  end
  
  private
    def require_administrator
		unless session[:employee_type] == "Administrator"
			flash[:notice] = "Unauthorized access."
			redirect_to '/admin/management'
		end
	end

  
end

