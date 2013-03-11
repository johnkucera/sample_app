# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
	attr_accessible :name, :email, :password, :password_confirmation
	
	#includes method to
	has_secure_password

	before_save { |user| user.email = email.downcase }

	#requires name to be populated to save a record, and max length of 80
	validates :name, presence: true, length: { maximum: 80} 
	
	#this sets the constant saying what the allowed pattern is
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	#requires email to always be populated, unique across all records, and of the above format
	validates :email, presence: true, uniqueness: { case_sensitive: false}, 
	format: { with: VALID_EMAIL_REGEX } 

	#requires min length of 6
	validates :password, length: { minimum: 6 }
end
