class Admin::MapAreasController < Admin::AdminMainController

  before_filter :require_administrator, :except=>[:index,:show]
  def index
	#pagination logic
	# count map_areas
	map_area_count = MapArea.count
	
	@no_of_pages = (map_area_count % 10)== 0 ? map_area_count/10 : (map_area_count/10) + 1
	
	@current_page = params[:page_no] ? params[:page_no].to_i : 1
	
	@sort_by = params[:sort_by] ? params[:sort_by] : "id"
	
	redirect_to "/admin/map_area/page/1/sort/#{@sort_by}" if params[:page_no].to_i > @no_of_pages
	
	@map_areas = MapArea.find(:all, :offset =>(@current_page-1) * 10, :limit=> 10, :order=>"#{@sort_by}")
	
  end

  def show
    @map_area = MapArea.find(params[:id])
  end
  
  def new
    @map_area = MapArea.new
  end

  def create
    @map_area = MapArea.new(params[:map_area])
    if @map_area.save
      flash[:notice] = "Added new map_area."
      redirect_to admin_map_area_path(@map_area)
    else
      flash[:notice] = "Failed saving new map_area."
      render :action => "new"
    end

    
  end

  def edit
    @map_area = MapArea.find(params[:id])
  end

  def update
    @map_area = MapArea.find(params[:id])
    if @map_area.update_attributes(params[:map_area])
      flash[:notice] = "Updated map_area."
      redirect_to admin_map_area_path(@map_area)
      
    else
      flash[:notice] = "Failed updating map_area."
      render :action => "edit"
    end

  end

  def destroy
    @map_area = MapArea.find(params[:id])
    if @map_area.destroy
      flash[:notice] = "Deleted map_area."
      
    else
      flash[:notice] = "Failed deleting map_area."
    end
    redirect_to admin_map_areas_path
  end
  
  private
    def require_administrator
		unless session[:employee_type] == "Administrator"
			flash[:notice] = "Unauthorized access."
			redirect_to '/admin/management'
		end
	end
end

