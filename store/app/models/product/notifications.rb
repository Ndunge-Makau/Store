module Product::Notifications
	extend ActiveSupport::Concern

	included do
		has_many :subscribers, dependent: :destroy
		after_update_commit :notify_subscribers, if: :back_in_stock?
	end

	def notify_subscribers
		subscribers.each do |subscriber|
			ProductMailer.with(product: self, subscriber: subscriber).in_stock.deliver_later
		end
	end

	def back_in_stock?
		(inventory_count_previously_was.zero? || inventory_count_previously_was.nil?) && inventory_count > 0
	end
end