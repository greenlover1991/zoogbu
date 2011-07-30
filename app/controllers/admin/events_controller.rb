class Admin::EventsController < Admin::AdminMainController

  before_filter :require_trainer, :except=>[:index, :show]
  def index
    # pagination logic
	# count events
	event_count = Event.count
	
	@no_of_pages = (event_count % 10)== 0 ? event_count/10 : (event_count/10) + 1
	
	@current_page = params[:page_no] ? params[:page_no].to_i : 1
	
	@sort_by = params[:sort_by] ? params[:sort_by] : "id"
	
	
	@events = Event.find(:all, :offset =>(@current_page-1) * 10, :limit=> 10, :order=>"#{@sort_by}")
  end

  def show
    @event = Event.find(params[:id])
  end
  
  def new
    @event = Event.new
    
  end

  def create	
    @event = Event.new(params[:event])

    if @event.save
      flash[:notice] = "Added new event."
      redirect_to admin_event_path(@event)
      
    else
      flash[:notice] = "Failed saving new event."
      render :action => "new"
    end
    
    
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    params[:event][:employee_ids] ||= []
    params[:event][:animal_ids] ||= []
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      flash[:notice] = "Updated event."
      redirect_to admin_event_path(@event)
      
    else
      flash[:notice] = "Failed updating event."
      render :action => "edit"
    end

  end

  def destroy
    @event = Event.find(params[:id])
    if @event.destroy
      flash[:notice] = "Deleted event."
      
    else
      flash[:notice] = "Failed deleting event."
    end
    redirect_to admin_events_path
  end

  private
    def require_trainer
		unless ["Trainer","Administrator"].include? session[:employee_type]
			flash[:notice] = "Unauthorized access."
			redirect_to '/admin/management'
		end
	end
end

