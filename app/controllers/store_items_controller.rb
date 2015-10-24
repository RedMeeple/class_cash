class StoreItemsController < ApplicationController
  before_action :set_store_item, only: [:show, :edit, :update, :destroy, :bought]
  before_action :instructor_logged_in?, except: [:buy, :bought]
  before_action :student_logged_in?, only: [:buy, :bought]

  def index
    @store_items = StoreItem.where(instructor_id: @instructor.id)
    @store_item = StoreItem.new
    @purchases = @instructor.purchases
    @periods = @instructor.periods
  end

  def buy
    @store_items = StoreItem.where(instructor_id: @student.period.instructor_id)
    @purchases = Purchase.where(student_id: @student.id)
    @periods = Period.where(instructor_id: @student.period.instructor_id)
    @transaction = Transaction.new(student_id: @student.id)
  end

  def bought
    if @student.cash > @store_item.price
      @purchase = Purchase.create(student_id: @student.id, store_item_id: @store_item.id)
      @purchase.finalize
      redirect_to buy_store_items_path, notice: "#{@store_item.name} was purchased."
    end
  end

  def instant_purchase
    student = Student.find(params[:purchase][:student_id].to_i)
    student.make_instant_purchase(params[:purchase][:amount].to_i, params[:purchase][:item])
    respond_to do |format|
      format.js
    end
  end

  def claim
    @purchase = Purchase.find(params[:id])
    @purchase.delete
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
