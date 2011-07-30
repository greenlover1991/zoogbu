class Admin::AdoptionsController < Admin::AdminMainController

  before_filter :require_human_resource

  def index
    # pagination logic
	# count adoptions
	adoption_count = Adoption.count
	
	@no_of_pages = (adoption_count % 10)== 0 ? adoption_count/10 : (adoption_count/10) + 1
	
	@current_page = params[:page_no] ? params[:page_no].to_i : 1
	
	@sort_by = params[:sort_by] ? params[:sort_by] : "id"
	
	@adoptions = Adoption.find(:all, :offset =>(@current_page-1) * 10, :limit=> 10, :order=>"#{@sort_by}")
	
  end

  def show
    @adoption = Adoption.find(params[:id])
  end
  
  def new
    @adoption = Adoption.new
  end

  def create
    @adoption = Adoption.new(params[:adoption])
    if @adoption.save
      flash[:notice] = "Added new adoption."
      redirect_to admin_adoption_path(@adoption)
      
    else
      flash[:notice] = "Failed saving new adoption."
      render :action => "new"
    end
    
    
  end

  def edit
    @adoption = Adoption.find(params[:id])
  end

  def update
    @adoption = Adoption.find(params[:id])
    if @adoption.update_attributes(params[:adoption])
      flash[:notice] = "Updated adoption."
      redirect_to admin_adoption_path(@adoption)
      
    else
      flash[:notice] = "Failed updating adoption."
      render :action => "edit"
    end

  end

  def destroy
    @adoption = Adoption.find(params[:id])
    if @adoption.destroy
      flash[:notice] = "Deleted adoption."
      
    else
      flash[:notice] = "Failed deleting adoption."
    end
    redirect_to admin_adoptions_path
  end
  
  private
    def require_human_resource
		unless ["Human Resource", "Administrator"].include? session[:employee_type]
			flash[:notice] = "Unauthorized access."
			redirect_to '/admin/management'
		end		
	end


end
