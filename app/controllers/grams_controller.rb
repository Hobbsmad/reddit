class GramsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :upvote, :downvote]

  def index
    if params[:search]
      @grams = Gram.search(params[:search]).page(params[:page]).per_page(25).order('created_at DESC')
    else
      @grams = Gram.all.page(params[:page]).per_page(25).order('created_at DESC')
    end
  end

  def new
    @gram = Gram.new
  end

  def create
    @gram = current_user.grams.create(gram_params)

    if @gram.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
  end

  def edit
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
    return render_not_found(:forbidden) if @gram.user != current_user
  end

  def update
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
    return render_not_found(:forbidden) if @gram.user != current_user

    @gram.update_attributes(gram_params)
    if @gram.valid?
      redirect_to root_path
    else
      return render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
    return render_not_found(:forbidden) if @gram.user != current_user
    @gram.destroy
    redirect_to root_path
  end

def upvote
  @gram = Gram.find(params[:id])
  current_user.vote_exclusively_for(@gram)

  redirect_to gram_path(@gram)
end

def downvote
  @gram = Gram.find(params[:id])
  current_user.vote_exclusively_against(@gram)

  redirect_to gram_path(@gram)
end

  private

  def gram_params
    params.require(:gram).permit(:message)
  end

  def gram_params
      params.require(:gram).permit(:message, :picture, :title)
    end

    def vote_up
    begin
      current_user.vote_for(@gram = Gram.find(params[:id]))
      render :nothing => true, :status => 200
    rescue ActiveRecord::RecordInvalid
      render :nothing => true, :status => 404
    end
  end

end
