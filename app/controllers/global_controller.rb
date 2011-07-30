class GlobalController < ApplicationController
  layout 'global'

  # restart the starting month for calendar to current month
  before_filter :set_start_month, :only=>'events'

  def index
    @title = "home"
	
    @animal = Animal.find(:first, :offset=>(rand*Animal.count).to_i)
    @habitat = Habitat.find(:first, :offset=>(rand*Habitat.count).to_i)
    @event = Event.find(:first, :offset=>(rand*Event.count).to_i)
    @comment = Comment.new
	
	
    post_count = Post.count(:conditions=>"status = 'Active'")
	
    @no_of_pages = (post_count % 3)== 0 ? post_count/3 : (post_count/3) + 1
    @current_page = params[:page_no] ? params[:page_no].to_i : 1
			
    redirect_to "/index/page/1" if params[:page_no].to_i > @no_of_pages
    @posts = Post.find(:all, :offset =>(@current_page-1) * 3, :limit=> 3, :conditions => ["status = 'Active'"], :order=>"created_at DESC")

	
  end

  def events
    @title = "events"
    calendarize(Date.today)
  end

  def gallery
    @title = "gallery"
    
	# collect all images for gallery viewing
	animals = Animal.find(:all, :select=>'img_url, img_description, updated_at')
    habitats = Habitat.find(:all, :select=>'img_url, img_description, updated_at')
    events = Event.find(:all, :select=>'img_url, img_description, updated_at')
	images = animals + habitats + events
	
	# sort it by updated_at dates
	@images = images.sort_by do |image|
	   image.updated_at
	end
	
	
	
  end

  def zoomap
    @title = "map"
	@zoomap = Zoomap.find(:first, :conditions=>"status = 'Active'",:order=>"updated_at")
	
  end

 
  def zoogle
    @title = "zoogle"
  end
  
  def find
	# if Animal was selected, include the other filters
	if params[:search_type] == "Animal"
		# include other conditions
		@animals = Animal.find(:all, :conditions=>["name LIKE ? 
								AND (kingdom_id = ? OR phylum_id = ? 
								OR aclass_id = ? OR aorder_id =	? 
								OR family_id = ? OR genus_id = ?
								OR species_id = ?)", '%' + params[:search_string] + '%',
								params[:animal][:kingdom_id], params[:animal][:phylum_id],
								params[:animal][:aclass_id], params[:animal][:aorder_id],
								params[:animal][:family_id], params[:animal][:genus_id],
								params[:animal][:species_id]], :order=>'name')
		@search_results = 'animal_search_results'
	# else if Habitat
	elsif params[:search_type] == "Habitat"
		# find habitat with given keyword
		@habitats = Habitat.find(:all, :conditions=>["name LIKE BINARY ? AND habitat_type_id = ? ", '%' + params[:search_string] + '%', params[:habitat_type][:id]])
		@search_results = 'habitat_search_results'
	# else if Event
	elsif params[:search_type] == "Event"
		# string format from_date
		from_year = params[:date_from]["(1i)"]
		from_month = "%02d" % params[:date_from]["(2i)"]
		from_day = "%02d" % params[:date_from]["(3i)"]
		
		from_date = from_year + "-" + from_month + "-" + from_day  
		
		# string format to_date
		to_year = params[:date_to]["(1i)"]
		to_month = "%02d" % params[:date_to]["(2i)"]
		to_day = "%02d" % params[:date_to]["(3i)"]
		
		to_date = to_year + "-" + to_month + "-" + to_day
		
		# find events having the keyword
		events = Event.find(:all, :conditions=>["name LIKE ?", '%' + params[:search_string] + '%'])
		# collect its id's
		event_ids = []
		events.each { |e| event_ids << e.id} 
		# find performances within the date and the given name
		@events = Performance.find_all_by_event_id(event_ids, :conditions=>["event_date >= ? AND event_date <= ?", from_date, to_date], :order=>'event_date')
		
		@search_results = 'event_search_results'
	else
		redirect_to '/zoogle'
	end
  end

 
  def subscribe
    @title = "subscribe"
	@subscriber = Subscriber.new
	@client = Sponsor.new
	@post = Post.new
  end
  
  
  

  def aboutus
    @title = "about"
	@posts = Post.find(:all, :offset=>(rand*Post.count).to_i, :limit=>'3', :conditions => ["status = 'Active'"])

  end
  
  def previous_month
    session[:month_ctr] -= 1
    calendarize(Date.today.months_since(session[:month_ctr]))
    respond_to do |format|
        format.js { render :layout=>false }
    end
  end

  def next_month
    session[:month_ctr] += 1
    calendarize(Date.today.months_since(session[:month_ctr]))
    respond_to do |format|
        format.js { render :layout=>false }
    end
  end
  
  
  
  def show_events
    @events_for_the_day = Performance.find(:all ,:conditions=> "event_date = '#{params[:event_date]}' ", :order=>"event_start ASC", :include=>'event')
    respond_to do |format|
        format.js { render :layout=>false }
    end
  end
  
  def subscribing
	  # if mailing list was clicked
	  if params[:form_type] == 'subscriber'
	    s = Subscriber.new(params[:subscriber])
		if s.save
			flash[:notice] = "Thanks for subscribing. An email will be sent for verification."
		else
			flash[:notice] = "Failed subscribing."
		end
		redirect_to '/subscribe'
	  # else client
	  elsif params[:form_type] == 'client'
	    if params[:client_type] == 'sponsor'
			s = Sponsor.new(params[:sponsor])
			s.sponsorship_level = 0
		else
			s = Buyer.new(params[:sponsor])
		end
		
		if params[:mailing]
			subscriber = Subscriber.new
			subscriber.first_name = s.name
			subscriber.last_name = s.name
			subscriber.email = params[:email]
			subscriber.contact_no = s.contact_no
			unless subscriber.save
				flash[:notice] = "Failed subscribing."
			else
				flash[:notice] = "Thanks for subscribing. We will contact you as soon as possible."
			end
		end
		
		if s.save
			flash[:notice] = "Thanks for subscribing."
		else
			flash[:notice] = "Failed subscribing."
		end
		redirect_to '/subscribe'
	  # post a review	
	  else
		post = Post.new(params[:post])
		if(post.save)
			flash[:notice] = "Thanks for posting."
		else
			flash[:notice] = "Failed posting."
		end
		redirect_to '/subscribe'
	  end
  end
  
  
   def animal_profile
	@animal = Animal.find(params[:id])
	@related = Animal.find(:all, :offset => (rand*Animal.count).to_i, :limit => '5')     
   end
   
   def habitat_profile
      @habitat = Habitat.find(params[:id])
	@related = Habitat.find(:all, :offset => (rand*Habitat.count).to_i, :limit => '3')     
   end

   def event_profile
    @event = Event.find(params[:id])
	@performances = Performance.find(:all, :conditions=>["event_id = ?", @event.id])
   end
 
	def commenting
		if(params[:comment])
			@comment = Comment.new(params[:comment])
			if @comment.save
			  flash[:notice] = "Posted new comment."
			  redirect_to '/'
			  
			else
			  flash[:notice] = "Failed posting new comment."
			  redirect_to '/'
			end
		else
			redirect_to '/'
		end
	end
	
	def posting
		if(params[:post])
			@post = Comment.new(params[:post])
			if @post.save
			  flash[:notice] = "Post Submitted"
			  redirect_to '/'
			  
			else
			  flash[:notice] = "Failed Submission Of Post"
			  redirect_to '/'
			end
		else
			redirect_to '/'
		end
	end
	
  private
    # prepares the calendar view
    def calendarize(cur_month)
      @skip_days = (cur_month.beginning_of_month.cwday % 7)
      @trailing_days = 6 - cur_month.end_of_month.cwday
      @no_of_days = cur_month.end_of_month.day
      @month = Date::MONTHNAMES[cur_month.month]
      @year = cur_month.year
      @performances = Performance.find(:all, :select=>"event_date, event_id", :conditions=> "event_date >= '#{cur_month.beginning_of_month}' AND event_date <= '#{cur_month.end_of_month}'", :order=> "event_date ASC", :group=>[:event_date,:event_id] )

    end
    
    # just because the class variables dont work. ugh :D
    def set_start_month
      session[:month_ctr] = 0
    end
   



end
