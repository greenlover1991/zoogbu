class Admin::AdminMainController < ApplicationController
  layout 'admin'

  before_filter :require_login, :except=> [:login,:authenticating]
  # initialize title to management so that the browsing of #animals, etc will have management_sidebar
  before_filter :init_title

				
				
	
  def login
    @title = "Login"
    redirect_to '/admin' if session[:username]
  end  

  def search
    @title = "Search"
    # if with search string
    if params[:search_string]
		@animals = []
		@employees = []
		@events=[]
		@habitats=[]
		unless params[:search_string].blank?
			ss = '%' + params[:search_string] + '%'

			# search for all animals by its name, description and taxonomy, given the keyword ss
			@animals = Animal.find(:all,:joins=>[:kingdom,:phylum,:aclass,:aorder,:family,:genus,:species,:habitat],
			:conditions=>["animals.gender = ? OR animals.name LIKE ? OR animals.description LIKE ?  OR animals.motto LIKE ?
								OR kingdoms.name LIKE ? OR phylums.name LIKE ? 
								OR aclasses.name LIKE ? OR aorders.name LIKE ? 
								OR families.name LIKE ? OR genus.name LIKE ?
								OR species.name LIKE ? OR habitats.name LIKE ? ",params[:search_string] ,ss,
								ss,ss,ss,ss,ss,ss,ss,ss,ss,ss],:order=>'animals.name')
			@animals += Animal.find(:all, :joins=> [:statuses], :conditions=> ["statuses.name LIKE ?",ss])
			
			#Search for Employees only if HR or admin
			if ["Human Resource", "Administrator"].include? session[:employee_type]
				@employees = Employee.find(:all,:conditions=>["first_name LIKE ? OR  last_name LIKE ? OR middle_name LIKE ? OR employee_type LIKE ? OR
												address LIKE ? OR gender = ?",ss,ss,ss,ss,ss,params[:search_string] ])
				@employees += Employee.find(:all, :joins=> [:events,:skills],
				:conditions=> ["events.name LIKE ? OR skills.name LIKE ?",ss,ss])
			end
			#Search for Events
			@events = Event.find(:all,:conditions=>["name LIKE ? OR  description LIKE ?",ss,ss ])
			@events += Event.find(:all, :joins=> [:habitat],
			:conditions=> ["habitats.name LIKE ? OR habitats.description LIKE ?",ss,ss])
			
			#Search for habitats
			@habitats = Habitat.find(:all,:conditions=>["name LIKE ? OR  description LIKE ?",ss,ss ])
			@habitats += Habitat.find(:all, :joins=> [:habitat_type], :conditions=> ["habitat_types.name LIKE ? OR habitat_types.description LIKE ?",ss,ss])

			#Delete Duplicates
			@employees.uniq!
			@events.uniq!
			@animals.uniq!
			@habitats.uniq!
		end
    else
	    redirect_to '/admin'
    end
  end  


  def logout
    session[:username] = nil
	session[:employee_type] = nil
	flash[:notice] = "Successfully logged out."
    redirect_to '/admin/login'
  end

  def index
    @title = "Summary"
	if session[:username] != "default"
		@user = User.find_by_username(session[:username])
		@user_img_url = @user.employee.img_url ? @user.employee.img_url : "/images/admin/Administrator-icon.png" 
		init_responsibilities
	else
		@user_img_url = "/images/admin/Administrator-icon.png" 
	end
	init_notifications
    
  end

  def management
    @title = "Management"
	if session[:username] != "default"
		@user = User.find_by_username(session[:username])
		@user_img_url = @user.employee.img_url ? @user.employee.img_url : "/images/admin/Administrator-icon.png" 
		init_responsibilities
	else
		@user_img_url = "/images/admin/Administrator-icon.png" 
	end

  end

  def reports
    @title = "Reports"
	init_notifications
	
	@no_active_subs = 0
	@no_cancelled_subs = 0
	@no_pending_subs = 0
	@no_subs = 0
	@no_posts = 0
	@no_active_posts = 0
	@no_employees = 0
	@no_zookeepers = 0
	@no_trainers = 0
	@no_admins = 0
	@no_other_employees = 0
	@no_events = 0 
	@total_visits = 0 
	@no_animals = 0
	@starting_year = Time.now.year 
	@average_annual_growth = 0
	
	#OTHERS
	@no_active_subs = Subscriber.count(:all,:conditions=>["status ='Active'"])
	@no_cancelled_subs = Subscriber.count(:all,:conditions=>["status ='Cancelled'"])
	@no_pending_subs = Subscriber.count(:all,:conditions=>["status ='Pending'"])
	@no_subs = Subscriber.count(:all)
	
	@no_posts = Post.count(:all)
	@no_active_posts = Post.count(:all, :conditions=>["status ='Active'"])
    #EMPLOYEES
	@no_employees = Employee.count(:all)
	@no_zookeepers = Employee.count(:all, :conditions=>["employee_type = 'Zookeeper'"])
	@no_trainers = Employee.count(:all, :conditions=>["employee_type = 'Trainer'"])
	@no_admins = Employee.count(:all, :conditions=>["employee_type = 'Administrator'"])
	@no_other_employees = Employee.count(:all, :conditions=>["employee_type != 'Administrator' AND employee_type != 'Trainer' AND employee_type != 'Zookeeper'"])
	
	
	#EVENTS
	@no_events = Event.count(:all)
	@average_performances = []
	psum = Performance.count(:all, :group => 'event')
	psum.each do |p|
		@average_performances << p[1].to_f
	end
	
	@total_visits = Performance.sum(:no_of_visitors)
	
	
	@average_performances = @average_performances.sum.to_f / @average_performances.size.to_f
	
    #ANIMALS
	@no_animals = Animal.count(:all)
	animal = Animal.find(:first, :order=>"created_at")
	starting_date = animal.created_at
	@starting_year = starting_date.year
	annual_animal_count = []

	while(starting_date.year <= Time.now.year)
		annual_animal_count << Animal.count(:conditions => "created_at <= '#{Date.new(starting_date.year,12,31).to_s(:db)}'")
		starting_date = starting_date.since(1.year) 
	end
	

	annual_growth = [1]

	i = 0

	while(i<annual_animal_count.size-1)
		annual_growth[i] = (annual_animal_count[i+1] - annual_animal_count[i] ).to_f/ annual_animal_count[i].to_f
		i+=1
    end
	@average_annual_growth = annual_growth.sum.to_f / annual_growth.size.to_f
	

  end


  def authenticating
    
	if !params[:username]
	  redirect_to '/admin'
    elsif has_no_admin? && (params[:username] == "default" && params[:password] == "admin")
      session[:username] = "default"
	  session[:employee_type] = "Administrator"
	  flash[:notice] = "Successfully logged in."
      redirect_to '/admin'
    elsif (user = User.find_by_username_and_password(params[:username], Digest::SHA1.hexdigest(params[:password])))
	  session[:username] = user.username
      session[:employee_type] = user.employee.employee_type
	  flash[:notice] = "Successfully logged in."
	  redirect_to '/admin'  
    else
      flash[:notice] = "Invalid username or password."
      redirect_to '/admin/login'
    end
	
  end
  
  


  private
    def require_login
      unless session[:username]
        flash[:notice] = "You must be logged in to access this section."
        redirect_to '/admin/login'
      end
    end
    
    # fail-safe check incase there are no users that are admin
    def has_no_admin?
       if e = Employee.find_by_employee_type("Administrator")
	     if User.find_by_employee_id(e)
		   return false
		 else
		   return true
		 end
	   else 
		 return true
	   end
    end
    
	def init_title
		@title = "Management"
	end
	
 	def init_notifications

		# ANIMAL NOTIFS
		@pregnant_animals = []
		@pregnant_animals += Animal.joins(:statuses).where(:statuses =>{:name => 'Pregnant'})

		@injured_animals = []
		@injured_animals += Animal.joins(:statuses).where(:statuses =>{:name => 'Injured'})

		@new_animals = []
		@new_animals += Animal.find(:all, :conditions=>["animals.created_at >= '#{Time.now.ago(7.days).to_s(:db)}'"])

		@bought_animals = []
		@bought_animals += Animal.joins(:adoption).where(:adoptions => {:created_at => (Time.now.ago(7.days)..Time.now)})

		@sponsored_animals = []
		@sponsored_animals += Animal.joins(:sponsorship).where(:sponsorships => {:created_at => (Time.now.ago(7.days)..Time.now)})


		#EMPLOYEE  NOTIFS
		@new_employees = []
		@new_employees += Employee.find(:all, :conditions=>["employees.created_at >= '#{Time.now.ago(7.days).to_s(:db)}'"])

		@bday_employees = []
		@bday_employees += Employee.where(:birthdate => Date.today)
		
		#EVENTS
		@new_events = []
		@new_events += Event.find(:all, :conditions=>["events.created_at >= '#{Time.now.ago(7.days).to_s(:db)}'"])
		
		@upcoming_performances = []
		@upcoming_performances += Performance.find(:all, :conditions=>["event_date >= '#{Date.today.beginning_of_month.to_s(:db)}' AND event_date <='#{Date.today.end_of_month.to_s(:db)}'"],:order=>'event_date ASC')
		
		#OTHER
		@pending_subscriptions = []
		@pending_subscriptions = Subscriber.find(:all, :conditions=>["status = 'Pending'"])
		
		@active_posts = []
		@active_posts = Post.find(:all,:conditions=>["status = 'Pending'"])
		
		@new_comments = []
		@new_comments = Comment.find(:all, :conditions=>["created_at >= '#{Time.now.ago(7.days).to_s(:db)}'"])

	end    
    
	def init_responsibilities()
		if session[:employee_type] == "Trainer"
			@events = []
			@events += @user.employee.events
		elsif session[:employee_type] == "Zookeeper"
			@maintenances = []
			@maintenances += @user.employee.maintenances
		end
	end


end
