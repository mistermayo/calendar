class DaysController < ActionController::Base
  layout "application"

  def home
    @days = Day.all
    @activities = Activity.all
  end

  def index
    if params[:query].present?
      @days = Day.search(params[:query], day_params: params[:day_params])
    else
      @days = Day.all
      @activities = Activity.all
    end
  end

  def new
    @day = Day.new
  end

  def show
    @day = Day.find(params[:id])
    @activities = @day.activities.all
  end

  def edit
    @day = Day.find(params[:id])
  end

  def create
    @day = Day.new(day_params)
    if @day.save
      flash[:notice] = "Posted Sucessfully!!"
       redirect_to days_path
     else
      render :new
    end
  end

  def destroy
    @day = Day.find(params[:id])
    @day.destroy
    flash[:notice] = "Smell you later, day."
    redirect_to day_path
  end

  def update
     @day = Day.find(params[:id])
     if @day.update(params[:day])
       redirect_to day_path
     else
       render :edit
     end
   end
private

  def day_params
    params.require(:day).permit(:description, :date, :url, :activity_id)
  end
end
