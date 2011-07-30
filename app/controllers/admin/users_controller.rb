class Admin::UsersController < Admin::AdminMainController

  before_filter :require_administrator
  def index
    # pagination logic
	# count users
	user_count = User.count
	
	@no_of_pages = (user_count % 10)== 0 ? user_count/10 : (user_count/10) + 1
	
	@current_page = params[:page_no] ? params[:page_no].to_i : 1
	
	@sort_by = params[:sort_by] ? params[:sort_by] : "id"
	
	@users = User.find(:all, :offset =>(@current_page-1) * 10, :limit=> 10, :order=>"#{@sort_by}")
	
  end

  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end

  def create
    params[:user][:password] = Digest::SHA1.hexdigest(params[:user][:password])
    params[:user][:password_confirmation] = Digest::SHA1.hexdigest(params[:user][:password_confirmation])
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Added new user."
      redirect_to admin_user_path(@user)
      
    else
      flash[:notice] = "Failed saving new user."
      render :action => "new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    params[:user][:password] = Digest::SHA1.hexdigest(params[:user][:password])
    params[:user][:password_confirmation] = Digest::SHA1.hexdigest(params[:user][:password_confirmation])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Updated user."
      redirect_to admin_user_path(@user)
      
    else
      flash[:notice] = "Failed updating user."
      render :action => "edit"
    end

  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "Deleted user."
    else
      flash[:notice] = "Failed deleting user."
    end
    redirect_to admin_users_path
  end
  
  private
    def require_administrator
		unless session[:employee_type] == "Administrator" 
			flash[:notice] = "Unauthorized access."
			redirect_to '/admin/management'
		end
	end

end

