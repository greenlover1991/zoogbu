class Admin::SubscribersController < Admin::AdminMainController

  before_filter :require_human_resource
  def index
	# pagination logic
	# count subscribers
	subscriber_count = Subscriber.count
	
	@no_of_pages = (subscriber_count % 10)== 0 ? subscriber_count/10 : (subscriber_count/10) + 1
	
	@current_page = params[:page_no] ? params[:page_no].to_i : 1
	
	@sort_by = params[:sort_by] ? params[:sort_by] : "status DESC"

	
	@subscribers = Subscriber.find(:all, :offset =>(@current_page-1) * 10, :limit=> 10, :order=>"#{@sort_by}")
	    
  end

  def show
    @subscriber = Subscriber.find(params[:id])
  end
  
  def new
    @subscriber = Subscriber.new
  end

  def create
    @subscriber = Subscriber.new(params[:subscriber])
    if @subscriber.save
      flash[:notice] = "Added new subscriber."
      redirect_to admin_subscriber_path(@subscriber)
      
    else
      flash[:notice] = "Failed saving new subscriber."
      render :action => "new"
    end
    
    
  end

  def edit
    @subscriber = Subscriber.find(params[:id])
  end

  def update
    @subscriber = Subscriber.find(params[:id])
    if @subscriber.update_attributes(params[:subscriber])
      flash[:notice] = "Updated subscriber."
      redirect_to admin_subscriber_path(@subscriber)
      
    else
      flash[:notice] = "Failed updating subscriber."
      render :action => "edit"
    end

  end

  def destroy
  
    @subscriber = Subscriber.find(params[:id])
    if @subscriber.destroy
      flash[:notice] = "Deleted subscriber."
      
    else
      flash[:notice] = "Failed deleting subscriber."
    end
    redirect_to admin_subscribers_path
  end
	
 
  private
    def require_human_resource
		unless ["Human Resource","Administrator"].include? session[:employee_type]
			flash[:notice] = "Unauthorized access."
			redirect_to '/admin/management'
		end
	end
end

