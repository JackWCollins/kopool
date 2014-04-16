class Season < ActiveRecord::Base
	has_many :weeks
	validates_presence_of :entry_fee
	validates_presence_of :name
	validates_presence_of :year
	validates_uniqueness_of :name, scope: :year
end
