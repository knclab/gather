class Admin::TagsController < Admin::BaseController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]

  def index
    @category = Category.includes(:tags).find(params[:category_id])
    @tags = @category.tags
  end

  def show
  end

  def new
    @category = Category.find(params[:category_id])
    @tag = Tag.new(category_id: @category.id)
  end

  def create
    @tag = Tag.new(tag_params)

    respond_to do |format|
      if @tag.save
        format.html { redirect_to [:admin, @tag], notice: 'Tag was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def edit

  end

  def update
    respond_to do |format|
      if @tag.update(tag_params)
        format.html { redirect_to [:admin, @tag], notice: 'Tag was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @tag.destroy
    respond_to do |format|
      format.html { redirect_to [:admin, @tag], notice: 'Tag was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_params
      params.require(:tag).permit(:category_id, :name)
    end
end
