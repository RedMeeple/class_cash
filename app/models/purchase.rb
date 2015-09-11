class Purchase < ActiveRecord::Base

  belongs_to :student
  belongs_to :store_item

  def finalize
    if store_item.stock
      store_item.update(stock: store_item.stock - 1)
    end
    student.update(cash: student.cash - store_item.price)
  end
end
