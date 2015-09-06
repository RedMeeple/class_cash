class StoreItemsController < ApplicationController
  before_action :set_store_item, only: [:show, :edit, :update, :destroy]
  before_action :instructor_logged_in?, except: [:buy, :bought]
  before_action :student_logged_in?, only: [:buy, :bought]

  def index
    @instructor = Instructor.find(current_user.id)
    @store_items = StoreItem.where(instructor_id: @instructor.id).where.not(stock: 0)
    @store_item = StoreItem.new
  end

  def buy
    @student = Student.find(current_user.id)
    @store_items = StoreItem.where(instructor_id: @student.period.instructor_id)
  end

  def bought
    respond_to do |format|
      format.js
    end
  end

  def show
  end

  def edit
  end

  def create
    @store_item = StoreItem.new(store_item_params)

    respond_to do |format|
      if @store_item.save
        format.html { redirect_to store_items_path, notice: 'Store item was successfully created.' }
        format.json { render :show, status: :created, location: @store_item }
      else
        format.html { render :new }
        format.json { render json: @store_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @store_item.update(store_item_params)
        format.html { redirect_to store_items_path, notice: 'Store item was successfully updated.' }
        format.json { render :show, status: :ok, location: @store_item }
      else
        format.html { render :edit }
        format.json { render json: @store_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /store_items/1
  # DELETE /store_items/1.json
  def destroy
    @store_item.destroy
    respond_to do |format|
      format.html { redirect_to store_items_url, notice: 'Store item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store_item
      @store_item = StoreItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_item_params
      params.require(:store_item).permit(:name, :price, :stock, :instructor_id)
    end
end
