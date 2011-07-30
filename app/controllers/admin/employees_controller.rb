class Admin::EmployeesController < Admin::AdminMainController

  # no exceptions, just the HR and Admin
  before_filter :require_human_resource
  def index
	# pagination logic
	# count employees
	employee_count = Employee.count
	
	@no_of_pages = (employee_count % 10)== 0 ? employee_count/10 : (employee_count/10) + 1
	
	@current_page = params[:page_no] ? params[:page_no].to_i : 1
	
	@sort_by = params[:sort_by] ? params[:sort_by] : "id"
	
	@employees = Employee.find(:all, :offset =>(@current_page-1) * 10, :limit=> 10, :order=>"#{@sort_by}")
	
	@employees.each {|e| e.calculate_years_employed}
  
  end

  #eager loading, for faster db req
  def show
    @employee = Employee.find(params[:id], :include=> :skills)
  end
  
  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(params[:employee])
    if @employee.save
      flash[:notice] = "Added new employee."
      redirect_to admin_employee_path(@employee)
    else
      flash[:notice] = "Failed saving new employee."
      render :action => "new"
    end

    
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def update
    params[:employee][:skill_ids] ||= []
    @employee = Employee.find(params[:id])
    
    
    if @employee.update_attributes(params[:employee])
      flash[:notice] = "Updated employee."
      redirect_to admin_employee_path(@employee)
      
    else
      flash[:notice] = "Failed updating employee."
      render :action => "edit"
    end

  end

  def destroy
    @employee = Employee.find(params[:id])
    if @employee.destroy
      flash[:notice] = "Deleted employee."
      
    else
      flash[:notice] = "Failed deleting employee."
    end
    redirect_to admin_employees_path
  end
  
  private
    def require_human_resource
		unless ["Human Resource","Administrator"].include? session[:employee_type]
			flash[:notice] = "Unauthorized access."
			redirect_to '/admin/management'
		end
	end
end


