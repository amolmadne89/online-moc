class GenerateOrderPdf

	def self.create_pdf(order)
		pdf = Prawn::Document.new(:page_layout => :portrait, :page_size => 'A4',:margin => [10, 10, 10, 50])
		#pdf.image "#{Rails.root}/app/assets/images/logo_old.png", :position => 10, :width => 100, :height => 50
		pdf.text "Order ##{order.id} Invoice", :size => 20, :style => :bold, :align => :center
		pdf.move_down(20)
		pdf.text "Customer Copy Receipt", :size => 15, :style => :bold, :align => :left
		pdf.text "Mad Over Chicken - The American Restaurant. Come &amp; enjoy freshly cook awesome food by American cuisine fried chicken restaurant. Mad Over Chicken (MOC) is being popular amongst all the age group for its largest variety of veg &amp; non veg burgers. If you get bore eating same type of burger then MOC is must go place for you they have unique 12 variety of burger starting @ just 35 which is the largest variety in india.", :size => 10, :style => :bold, :align => :left
		pdf.move_down(10)
		pdf.text "#{order.first_name}, #{order.mobile} ", :size => 10, :style => :bold, :align => :left
		pdf.text "#{order.address}", :size => 10, :style => :bold, :align => :left
		pdf.font_size(8) do
			# pdf.text "<b>OPERATOR : <b>" + Product.find(fleet.item_id).product_name, :inline_format => true
			pdf.move_down 6
			pdf.table order.order_data do |table|
		    table.column_widths = [80,80,80,80,80,80,80,80]
		    table.cell_style	= {:inline_format => true}
		  end
		  pdf.move_down 10
		end
		pdf.text "Total Price: #{order.total_price}", :size => 16, :style => :bold

		pdf.move_down 30
		pdf.text "MOC Copy Receipt", :size => 15, :style => :bold, :align => :left
		pdf.move_down(5)
		pdf.text "#{order.first_name}, #{order.mobile} ", :size => 10, :style => :bold, :align => :left
		pdf.text "#{order.address}", :size => 10, :style => :bold, :align => :left
		pdf.font_size(8) do
			# pdf.text "<b>OPERATOR : <b>" + Product.find(fleet.item_id).product_name, :inline_format => true
			pdf.move_down 6
			pdf.table order.order_data do |table|
		    table.column_widths = [80,80,80,80,80,80,80,80]
		    table.cell_style	= {:inline_format => true}
		  end
		  pdf.move_down 10
		end
		pdf.text "Total Price: #{order.total_price}", :size => 16, :style => :bold

		pdf.move_down 30
		pdf.text "MOC Kitchen Copy Receipt", :size => 15, :style => :bold, :align => :left
		pdf.font_size(8) do
			# pdf.text "<b>OPERATOR : <b>" + Product.find(fleet.item_id).product_name, :inline_format => true
			pdf.move_down 6
			pdf.table order.order_data do |table|
		    table.column_widths = [80,80,80,80,80,80,80,80]
		    table.cell_style	= {:inline_format => true}
		  end
		  pdf.move_down 20
		end
		#footer
		options = { :at => [pdf.bounds.left + 0, 0],
		:width => 150,
		:align => :right,
		:inline_format => true }
		pdf.font_size(7){pdf.number_pages "* All information will be kept private and confidential", options}

		return pdf
	end

end
