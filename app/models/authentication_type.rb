class AuthenticationType < ActiveRecord::Base
end
# == Schema Information
#
# Table name: authentication_types
#
#  id         :integer         not null, primary key
#  provider   :string(255)
#  enable     :boolean
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

