# creating authentication types
if AuthenticationType.count == 0
	puts "Creating Types of Authentication"
	types = ['devise', 'facebook', 'linkedin', 'twitter']
	types.each do |type|
		AuthenticationType.create( :provider => type, :enable => true )
	end
	
	# Toggling authentication from seeds
	AuthenticationType.find_by_provider('twitter').update_attributes( :enable => false )
end

# Creating an admin user
if AdminUser.count == 0
	puts "Creating Admin account"
	AdminUser.create!(:email => 'admin@solivar.com', :password => 'password', :password_confirmation => 'password')
end

