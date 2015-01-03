module OrdersHelper
  def display_dish_action(order_dish)
    if order_dish.is_pending?
      link_to "Mark as PREPARING", "/mark_dishes_as_preparing?order_dish_id=#{order_dish.id}"
    elsif order_dish.is_preparing?
      link_to "Mark as READY", "/mark_dishes_as_ready?order_dish_id=#{order_dish.id}"
    elsif order_dish.is_ready?
      if current_user.waiter?
        link_to "Mark as DELIVERED", "/mark_dishes_as_delivered?order_dish_id=#{order_dish.id}"
      else
        "<b>Is ready</b>"
      end
    elsif order_dish.is_delivered?
      "<b>Delivered</b>"
    elsif order_dish.is_check?
      "<b>Checked</b>"
    elsif order_dish.is_payed?
      "<b>Payed</b>"
    end
  end

end
