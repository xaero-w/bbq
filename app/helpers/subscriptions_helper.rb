module SubscriptionsHelper
 # запрет подписки на свое событие
 def current_user_is_owner?(event)
   event.user == current_user
 end
end
