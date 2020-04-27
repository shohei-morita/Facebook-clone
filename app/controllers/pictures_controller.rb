class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  before_action :prevent_wrong_user, only: [:edit, :update, :destroy]

  def index
    @pictures = Picture.all.order("updated_at DESC")
    @picture = Picture.new
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = current_user.pictures.build(picture_params)
    if params[:back]
      render :new
    else
      if @picture.save
        redirect_to pictures_path
        flash[:notice] = "記事を投稿しました。"
      else
        render :new
      end
    end
  end

  def show; end

  def edit; end

  def update
    if params[:delete_image]
      @picture.image = nil
      @picture.save
      render :edit
      return
    end

    if params[:back]
      redirect_to pictures_path
    else
      if @picture.update(picture_params)
        redirect_to pictures_path
        flash[:notice] = "記事を編集しました。"
      else
        render :edit
      end
    end
  end

  def destroy
    @picture.destroy
    redirect_to pictures_path
    flash[:danger] = "記事を削除しました。"
  end

  def confirm
    @picture = current_user.pictures.build(picture_params)
    render :new if @picture.invalid?
  end

  private
  def picture_params
    params.require(:picture).permit(:title, :content, :image, :image_cache)
  end

  def set_picture
    @picture = Picture.find(params[:id])
  end

  def prevent_wrong_user
    @picture = Picture.find_by(id: params[:id])
    if @picture.user_id != current_user.id
      redirect_to pictures_path,
      flash[:danger] = "権限がありません。"
    end
  end

end
