class Admin::HabitatsController < Admin::AdminMainController

  before_filter :require_administrator, :except=>[:index,:show]
  def index
    # pagination logic
	# count habitats
	habitat_count = Habitat.count
	
	@no_of_pages = (habitat_count % 10)== 0 ? habitat_count/10 : (habitat_count/10) + 1
	
	@current_page = params[:page_no] ? params[:page_no].to_i : 1
	
	@sort_by = params[:sort_by] ? params[:sort_by] : "id"
	

	@habitats = Habitat.find(:all, :offset =>(@current_page-1) * 10, :limit=> 10, :order=>"#{@sort_by}")
  end

  def show
    @habitat = Habitat.find(params[:id], :include=>:animals)
  end
  
  def new
    @habitat = Habitat.new
  end

  def create
    @habitat = Habitat.new(params[:habitat])
    if @habitat.save
      flash[:notice] = "Added new habitat."
      redirect_to admin_habitat_path(@habitat)
    else
      flash[:notice] = "Failed saving new habitat."
      render :action => "new"
    end

    
  end

  def edit
    @habitat = Habitat.find(params[:id])
  end

  def update
    @habitat = Habitat.find(params[:id])
    if @habitat.update_attributes(params[:habitat])
      flash[:notice] = "Updated habitat."
      redirect_to admin_habitat_path(@habitat)
      
    else
      flash[:notice] = "Failed updating habitat."
      render :action => "edit"
    end

  end

  def destroy
    @habitat = Habitat.find(params[:id])
    if @habitat.destroy
      flash[:notice] = "Deleted habitat."
      
    else
      flash[:notice] = "Failed deleting habitat."
    end
    redirect_to admin_habitats_path
  end
  
  private
    def require_administrator
		unless session[:employee_type] == "Administrator"
			flash[:notice] = "Unauthorized access."
			redirect_to '/admin/management'
		end
	end
end


