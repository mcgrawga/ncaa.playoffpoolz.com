class Admin < User
  validates_uniqueness_of :pool_name
	validates :pool_name, :presence => true
	validates :first_name, :presence => true
	validates :last_name, :presence => true
end
