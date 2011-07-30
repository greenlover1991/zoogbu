class Admin::SkillsController < Admin::AdminMainController
  
  before_filter :require_human_resource, :except=>[:index, :show]
  def index
    # pagination logic
	# count skills
	skill_count = Skill.count
	
	@no_of_pages = (skill_count % 10)== 0 ? skill_count/10 : (skill_count/10) + 1
	
	@current_page = params[:page_no] ? params[:page_no].to_i : 1
	
	@sort_by = params[:sort_by] ? params[:sort_by] : "id"
	
	@skills = Skill.find(:all, :offset =>(@current_page-1) * 10, :limit=> 10, :order=>"#{@sort_by}")
	
  end

  def show
    @skill = Skill.find(params[:id])
  end
  
  def new
    @skill = Skill.new
  end

  def create
    @skill = Skill.new(params[:skill])
    if @skill.save
      flash[:notice] = "Added new skill."
      redirect_to admin_skill_path(@skill)
      
    else
      flash[:notice] = "Failed saving new skill."
      render :action => "new"
    end
    
    
  end

  def edit
    @skill = Skill.find(params[:id])
  end

  def update
    @skill = Skill.find(params[:id])
    if @skill.update_attributes(params[:skill])
      flash[:notice] = "Updated skill."
      redirect_to admin_skill_path(@skill)
      
    else
      flash[:notice] = "Failed updating skill."
      render :action => "edit"
    end

  end

  def destroy
    @skill = Skill.find(params[:id])
    if @skill.destroy
      flash[:notice] = "Deleted skill."
      
    else
      flash[:notice] = "Failed deleting skill."
    end
    redirect_to admin_skills_path
  end
  
  private
    def require_human_resource
		unless ["Human Resource","Administrator"].include? session[:employee_type]
			flash[:notice] = "Unauthorized access."
			redirect_to '/admin/management'
		end
	end
end

