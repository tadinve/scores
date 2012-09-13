class UsersController < ApplicationController
	
	respond_to :html, :json

	def index
		@users = User.all
	end

	def update
		@user = current_user
		if params[:user]
			@user.update_attributes params[:user]
			respond_with @user
		end
	end

	def export_to_excel
		@users = User.all
		book = Spreadsheet::Workbook.new
		sheet1 = book.create_worksheet :name => 'Users'
		sheet1.row(0).push 'First Name', 'Last Name', 'Email Address'
		@users.each_with_index do |u, i|
			sheet1.row(i+1).push u.first_name, u.last_name, u.email
		end

		blob = StringIO.new('')
		book.write blob
		send_data(blob.string, :type => :xls, :filename => "Users - #{DateTime.now.strftime("%m.%d.%y")}.xls")
		# send_data(sheet1, :type => :xls, :filename => "Users - #{DateTime.now.strftime("%m.%d.%y")}.xls")
	end

end