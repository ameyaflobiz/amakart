class GeneratePdfWorker
	include Sidekiq::Worker
	sidekiq_options retry:false

	def perform(invoice_id,seller_id,order_id)
		puts "Your invoice is being generated"

		invoice_obj = OrderProduct.find(invoice_id)

		begin
			grover = Grover.new("http://localhost:3000/orders/#{order_id}?seller_id=#{seller_id}", format: 'A4')
			pdf = grover.to_pdf
			File.open(("/Users/ameyajangam22/Desktop/rails-learn/amakart-invoices/Invoice_#{seller_id}_#{order_id}.pdf"),'wb', encoding: 'ascii-8bit') do |f|
				f.write(pdf)
				invoice_obj.invoice = f
			end 
		rescue Exception => e
			puts e

		end
		invoice_obj.save!
	    

	end
end