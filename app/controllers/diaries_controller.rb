class DiariesController < ApplicationController
  def index
    if current_user   
      @diaries = current_user.diaries
     # authorize @diaries
    else
      render 'welcome/index'
      flash[:error] = "Error: No user login."      
    end
  end

  def show
    @diary = Diary.find(params[:id])
    authorize @diary
  end

  def new
    @diary = Diary.new
    authorize @diary
  end
  
  def create
    @diary = Diary.new(diary_params)
    @diary.user = current_user
    authorize @diary
     if @diary.save
       flash[:notice] = "Diary was saved."
       redirect_to @diary
     else
       flash[:error] = "There was an error saving the diary. Please try again."
       render :new
     end
  end

  def edit
     @diary = Diary.find(params[:id])
     authorize @diary
  end

  def update
     @diary = Diary.find(params[:id])
     authorize @diary
     if @diary.update_attributes(diary_params)
       flash[:notice] = "Diary was updated."
       redirect_to @diary
     else
       flash[:error] = "There was an error saving the diary. Please try again."
       render :edit
     end
  end
  
  def destroy
  end
  
  private
  
  def diary_params
    params.require(:diary).permit(:title, :body)
  end
end
