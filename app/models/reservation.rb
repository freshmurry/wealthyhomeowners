class Reservation < ApplicationRecord
  enum status: {Waiting: 0, Approved: 1, Declined: 2}
  
  after_create_commit :create_notification
  
  belongs_to :user
  belongs_to :home
  
  scope :current_week_revenue, -> (user) {
    joins(:home)
    .where("homes.user_id = ? AND reservations.updated_at >= ? AND reservations.status = ?", user.id, 1.week.ago, 1)
    .order(updated_at: :asc)
  }

  private

    def create_notification
      type = self.home.Instant? ? "New Booking" : "New Request"
      guest = User.find(self.user_id)

      Notification.create(content: "#{type} from #{guest.fullname}", user_id: self.home.user_id)
    end
end