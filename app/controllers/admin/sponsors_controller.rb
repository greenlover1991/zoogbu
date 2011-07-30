class Admin::SponsorsController < Admin::AdminMainController

  before_filter :require_human_resource
  def index
	# pagination logic
	# count sponsors
	sponsor_count = Sponsor.count
	
	@no_of_pages = (sponsor_count % 10)== 0 ? sponsor_count/10 : (sponsor_count/10) + 1
	
	@current_page = params[:page_no] ? params[:page_no].to_i : 1
	
	@sort_by = params[:sort_by] ? params[:sort_by] : "id"
	
	@sponsors = Sponsor.find(:all, :offset =>(@current_page-1) * 10, :limit=> 10, :order=>"#{@sort_by}")
	
  end

  def show
    @sponsor = Sponsor.find(params[:id])
  end
  
  def new
    @sponsor = Sponsor.new
  end

  def create
    @sponsor = Sponsor.new(params[:sponsor])
    if @sponsor.save
      flash[:notice] = "Added new sponsor."
      redirect_to admin_sponsor_path(@sponsor)
      
    else
      flash[:notice] = "Failed saving new sponsor."
      render :action => "new"
    end
    
    
  end

  def edit
    @sponsor = Sponsor.find(params[:id])
  end

  def update
    @sponsor = Sponsor.find(params[:id])
    if @sponsor.update_attributes(params[:sponsor])
      flash[:notice] = "Updated sponsor."
      redirect_to admin_sponsor_path(@sponsor)
      
    else
      flash[:notice] = "Failed updating sponsor."
      render :action => "edit"
    end

  end

  def destroy
    @sponsor = Sponsor.find(params[:id])
    if @sponsor.destroy
      flash[:notice] = "Deleted sponsor."
      
    else
      flash[:notice] = "Failed deleting sponsor."
    end
    redirect_to admin_sponsors_path
  end
  
  private
    def require_human_resource
		unless ["Human Resource","Administrator"].include? session[:employee_type]
			flash[:notice] = "Unauthorized access."
			redirect_to '/admin/management'
		end
	end

end

