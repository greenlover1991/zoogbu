class Admin::PerformancesController < Admin::AdminMainController

  before_filter :require_trainer, :except=>[:index,:show]
  def index
    #pagination logic
	# count performances
	performance_count = Performance.count
	
	@no_of_pages = (performance_count % 10)== 0 ? performance_count/10 : (performance_count/10) + 1
	
	@current_page = params[:page_no] ? params[:page_no].to_i : 1
	
	@sort_by = params[:sort_by] ? params[:sort_by] : "id"
	
	redirect_to "/admin/performance/page/1/sort/#{@sort_by}" if params[:page_no].to_i > @no_of_pages
	
	@performances = Performance.find(:all, :offset =>(@current_page-1) * 10, :limit=> 10, :order=>"#{@sort_by}")
	
  end

  def show
    @performance = Performance.find(params[:id])
  end
  
  def new
    @performance = Performance.new
  end

  def create
    @performance = Performance.new(params[:performance])
    if @performance.save
      flash[:notice] = "Added new performance."
      redirect_to admin_performance_path(@performance)
    else
      flash[:notice] = "Failed saving new performance."
      render :action => "new"
    end

    
  end

  def edit
    @performance = Performance.find(params[:id])
  end

  def update
    @performance = Performance.find(params[:id])
    if @performance.update_attributes(params[:performance])
      flash[:notice] = "Updated performance."
      redirect_to admin_performance_path(@performance)
      
    else
      flash[:notice] = "Failed updating performance."
      render :action => "edit"
    end

  end

  def destroy
    @performance = Performance.find(params[:id])
    if @performance.destroy
      flash[:notice] = "Deleted performance."
      
    else
      flash[:notice] = "Failed deleting performance."
    end
    redirect_to admin_performances_path
  end
  
  private
    def require_trainer
		unless ["Trainer","Administrator"].include? session[:employee_type]
			flash[:notice] = "Unauthorized access."
			redirect_to '/admin/management'
		end
	end

end

