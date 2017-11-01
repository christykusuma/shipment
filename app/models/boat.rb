class Boat < ApplicationRecord
	belongs_to :user
	has_many :assignments
	has_many :jobs, through: :assignments
	validates :name, uniqueness:true
end

