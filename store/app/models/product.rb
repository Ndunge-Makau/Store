class Product < ApplicationRecord
	include Notifications
	validates :name, presence: true
	has_rich_text :description
	has_one_attached :featured_image
	validates :inventory_count, numericality: { greater_than_or_equal_to: 0 }
end
