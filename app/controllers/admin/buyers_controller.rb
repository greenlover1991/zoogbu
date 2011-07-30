class Admin::BuyersController < Admin::AdminMainController

  
  before_filter :require_human_resource
  def index
    # pagination logic
	# count buyers
	buyer_count = Buyer.count
	
	@no_of_pages = (buyer_count % 10)== 0 ? buyer_count/10 : (buyer_count/10) + 1
	
	@current_page = params[:page_no] ? params[:page_no].to_i : 1
	
	@sort_by = params[:sort_by] ? params[:sort_by] : "id"
	
	@buyers = Buyer.find(:all, :offset =>(@current_page-1) * 10, :limit=> 10, :order=>"#{@sort_by}")
	
  end

  def show
    @buyer = Buyer.find(params[:id])
  end
  
  def new
    @buyer = Buyer.new
  end

  def create
    @buyer = Buyer.new(params[:buyer])
    if @buyer.save
      flash[:notice] = "Added new buyer."
      redirect_to admin_buyer_path(@buyer)
      
    else
      flash[:notice] = "Failed saving new buyer."
      render :action => "new"
    end
    
    
  end

  def edit
    @buyer = Buyer.find(params[:id])
  end

  def update
    @buyer = Buyer.find(params[:id])
    if @buyer.update_attributes(params[:buyer])
      flash[:notice] = "Updated buyer."
      redirect_to admin_buyer_path(@buyer)
      
    else
      flash[:notice] = "Failed updating buyer."
      render :action => "edit"
    end

  end

  def destroy
    @buyer = Buyer.find(params[:id])
    if @buyer.destroy
      flash[:notice] = "Deleted buyer."
      
    else
      flash[:notice] = "Failed deleting buyer."
    end
    redirect_to admin_buyers_path
  end
  
  private
    def require_human_resource
		unless ["Human Resource","Administrator"].include? session[:employee_type]
			flash[:notice] = "Unauthorized access."
			redirect_to '/admin/management'
		end
	end

end

