class SubscribersController < ApplicationController
	before_action :set_product
	allow_unauthenticated_access only: %i[ create ]	

	# Create a new subscriber for the product
	def create
		@product.subscribers.where(subscriber_params).first_or_create
		redirect_to @product, notice: "You are Subscribed to #{@product.name}!"
	end

	# Set the product for the subscriber
	private
	def set_product
		@product = Product.find(params[:product_id])
	end

	# Define parameters expected to create a subscriber
	def subscriber_params
		params.expect(subscriber: [ :email ])
	end	
end