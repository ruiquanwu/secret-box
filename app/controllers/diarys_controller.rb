class DiarysController < ApplicationController
  def index
    @diarys = Diary.all
  end

  def show
    @diary = Diary.find(params[:id])
  end

  def new
  end

  def edit
  end
end
