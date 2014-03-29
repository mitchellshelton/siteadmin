class ContentsController < ApplicationController

  def index
    @contents = Content.all
  end

  def show
    @content = Content.find(params[:id])
  end

  def edit
    @content = Content.find(params[:id])
  end

  def update
    @content = Content.find(params[:id])
    if @content.update(content_params)
      redirect_to @content, notice: "Content successfully updated!"
    else
      render :edit
    end
  end

  def new
    @content = Content.new
  end

  def create
    @content = Content.new(content_params)
    if @content.save
      redirect_to @content, notice: "Content successfully created!"
    else
      render :new
    end
  end

  def destroy
    @content = Content.find(params[:id])
    @content.destroy
    redirect_to contents_url, alert: "Content successfully deleted!"
  end

  private

    def content_params
      params.require(:content).permit(:title, :body)
    end

end
