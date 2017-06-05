module ApplicationHelper
	def load_friend_requests
    @friend_requests ||= current_user.friend_requests.all
  end
end
