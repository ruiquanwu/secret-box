class DiariesController < ApplicationController
  def index
    @diaries = Diary.all
    authorize @diaries
  end

  def show
    @diary = Diary.find(params[:id])
  end

  def new
    @diary = Diary.new
    authorize @diary
  end
  
  def create
    @diary = Diary.new(params.require(:diary).permit(:title, :body))
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
   end

   def update
     @diary = Diary.find(params[:id])
     if @diary.update_attributes(params.require(:diary).permit(:title, :body))
       flash[:notice] = "Diary was updated."
       redirect_to @diary
     else
       flash[:error] = "There was an error saving the diary. Please try again."
       render :edit
     end
   end
end
