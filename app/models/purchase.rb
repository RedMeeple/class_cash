class Purchase < ActiveRecord::Base

  belongs_to :student
  belongs_to :store_item

  def finalize
    if store_item.stock
      store_item.update(stock: store_item.stock - 1)
    end
    if purchase = PurchaseTracker.where(student_id: student.id).find_by_item(store_item.name)
      purchase.update(amount: purchase.amount + store_item.price)
    else
      PurchaseTracker.create(student_id: student.id, item: store_item.name, amount: store_item.price)
    end
    student.update(cash: student.cash - store_item.price)
  end
end
