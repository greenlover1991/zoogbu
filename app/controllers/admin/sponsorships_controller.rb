class Admin::SponsorshipsController < Admin::AdminMainController

  before_filter :require_human_resource
  def index
    # pagination logic
	# count sponsorships
	sponsorship_count = Sponsorship.count
	
	@no_of_pages = (sponsorship_count % 10)== 0 ? sponsorship_count/10 : (sponsorship_count/10) + 1
	
	@current_page = params[:page_no] ? params[:page_no].to_i : 1
	
	@sort_by = params[:sort_by] ? params[:sort_by] : "id"
	
	redirect_to "/admin/sponsorship/page/1/sort/#{@sort_by}" if params[:page_no].to_i > @no_of_pages
	
	@sponsorships = Sponsorship.find(:all, :offset =>(@current_page-1) * 10, :limit=> 10, :order=>"#{@sort_by}")
	
  end

  def show
    @sponsorship = Sponsorship.find(params[:id])
  end
  
  def new
    @sponsorship = Sponsorship.new
  end

  def create
    @sponsorship = Sponsorship.new(params[:sponsorship])
    if @sponsorship.save
      flash[:notice] = "Added new sponsorship."
      redirect_to admin_sponsorship_path(@sponsorship)
      
    else
      flash[:notice] = "Failed saving new sponsorship."
      render :action => "new"
    end
    
    
  end

  def edit
    @sponsorship = Sponsorship.find(params[:id])
  end

  def update
    @sponsorship = Sponsorship.find(params[:id])
    if @sponsorship.update_attributes(params[:sponsorship])
      flash[:notice] = "Updated sponsorship."
      redirect_to admin_sponsorship_path(@sponsorship)
      
    else
      flash[:notice] = "Failed updating sponsorship."
      render :action => "edit"
    end

  end

  def destroy
    @sponsorship = Sponsorship.find(params[:id])
    if @sponsorship.destroy
      flash[:notice] = "Deleted sponsorship."
      
    else
      flash[:notice] = "Failed deleting sponsorship."
    end
    redirect_to admin_sponsorships_path
  end

  private
	def require_human_resource
		unless ["Human Resource", "Administrator"].include? session[:employee_type]
			flash[:notice] = "Unauthorized access."
			redirect_to '/admin/management'
		end		
	end
end

