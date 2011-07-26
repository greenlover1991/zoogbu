class Admin::AnimalsController < Admin::AdminMainController
  before_filter :require_zookeeper, :except=>[:index,:show]
  def index
	#pagination logic
	# count animals
	animal_count = Animal.count
	
	@no_of_pages = (animal_count % 10)== 0 ? animal_count/10 : (animal_count/10) + 1
	
	@current_page = params[:page_no] ? params[:page_no].to_i : 1
	
	@sort_by = params[:sort_by] ? params[:sort_by] : "id"
	
	redirect_to "/admin/animal/page/1/sort/#{@sort_by}" if params[:page_no].to_i > @no_of_pages
	
	@animals = Animal.find(:all, :offset =>(@current_page-1) * 10, :limit=> 10, :order=>"#{@sort_by}")
	@animals.each {|a| a.calculate_age}
	
  end

  #eager loading, for faster db req
  def show
    @animal = Animal.find(params[:id], 
              :include => [:kingdom, :phylum, :aclass, :aorder, 
              :family, :genus, :species, :habitat, :statuses])
  end
  
  def new
    @animal = Animal.new
  end

  def create
    @animal = Animal.new(params[:animal])
    if @animal.save
      flash[:notice] = "Added new animal."
      redirect_to admin_animal_path(@animal)
    else
      flash[:notice] = "Failed saving new animal."
      render :action => "new"
    end

    
  end

  def edit
    @animal = Animal.find(params[:id])
  end

  def update
    params[:animal][:status_ids] ||= []
    @animal = Animal.find(params[:id])
    if @animal.update_attributes(params[:animal])
      flash[:notice] = "Updated animal."
      redirect_to admin_animal_path(@animal)
      
    else
      flash[:notice] = "Failed updating animal."
      render :action => "edit"
    end

  end

  def destroy
    @animal = Animal.find(params[:id])
    if @animal.destroy
      flash[:notice] = "Deleted animal."
      
    else
      flash[:notice] = "Failed deleting animal."
    end
    redirect_to admin_animals_path
  end
  
  private
    def require_zookeeper
		unless ["Zookeeper","Administrator"].include? session[:employee_type]
			flash[:notice] = "Unauthorized access."
			redirect_to '/admin/management'
		end
	end
  
  
  
end


