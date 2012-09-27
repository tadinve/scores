class Profile < ActiveRecord::Base
  
  belongs_to :user

  attr_accessible :about

end
# == Schema Information
#
# Table name: profiles
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  about      :text
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

