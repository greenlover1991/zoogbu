class Admin::FoodsController < Admin::AdminMainController

  before_filter :require_zookeeper, :except=>[:index, :show] 
  def index
    # pagination logic
	# count foods
	food_count = Food.count
	
	@no_of_pages = (food_count % 10)== 0 ? food_count/10 : (food_count/10) + 1
	
	@current_page = params[:page_no] ? params[:page_no].to_i : 1
	
	@sort_by = params[:sort_by] ? params[:sort_by] : "id"
	
	@foods = Food.find(:all, :offset =>(@current_page-1) * 10, :limit=> 10, :order=>"#{@sort_by}")
  end

  def show
    @food = Food.find(params[:id])
  end
  
  def new
    @food = Food.new
  end

  def create
    @food = Food.new(params[:food])
    if @food.save
      flash[:notice] = "Added new food."
      redirect_to admin_food_path(@food)
      
    else
      flash[:notice] = "Failed saving new food."
      render :action => "new"
    end
  end

  def edit
    @food = Food.find(params[:id])
  end

  def update
    @food = Food.find(params[:id])
    if @food.update_attributes(params[:food])
      flash[:notice] = "Updated food."
      redirect_to admin_food_path(@food)
      
    else
      flash[:notice] = "Failed updating food."
      render :action => "edit"
    end

  end

  def destroy
    @food = Food.find(params[:id])
    if @food.destroy
      flash[:notice] = "Deleted food."
    else
      flash[:notice] = "Failed deleting food."
    end
    redirect_to admin_foods_path
  end
  
  private
    def require_zookeeper
		unless ["Zookeeper","Administrator"].include? session[:employee_type]
			flash[:notice] = "Unauthorized access."
			redirect_to '/admin/management'
		end
	end

end

