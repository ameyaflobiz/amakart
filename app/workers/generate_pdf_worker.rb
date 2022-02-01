class GeneratePdfWorker
	include Sidekiq::Worker
	sidekiq_options retry:false

	def perform(order_id)
		puts "Your invoice is being generated"

		items_in_order = OrderProduct.where(order_id: order_id)

		ActiveRecord::Base.transaction do

			items_in_order.each do |order_item|
				begin
					grover = Grover.new("http://localhost:3000/orders/#{order_id}?invoice_id=#{order_item.id}", format: 'A4')
					pdf = grover.to_pdf
					File.open(("/Users/ameyajangam22/Desktop/rails-learn/amakart-invoices/Invoice_#{order_item.id}_#{order_item.product_id}.pdf"),'wb', encoding: 'ascii-8bit') do |f|
						f.write(pdf)
						order_item.invoice = f
					end
					# Save karke we can access urls later on
					order_item.save! 
				rescue Exception => e
					puts e
				end	
			end
		
		end

		
		
	    

	end
end