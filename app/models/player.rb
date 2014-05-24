class PoolValidator < ActiveModel::Validator
  def validate(record)
      pool_count = User.where("lower(pool_name) = lower(?)", record.pool_name).count
      if (pool_count < 1)
              error_msg = record.pool_name
              error_msg += " was not found"
              record.errors[:pool_name] << error_msg
      end
  end
end

class Player < User
	validates :pool_name, :presence => true
	validates :first_name, :presence => true
	validates :last_name, :presence => true
	validates_with PoolValidator
end
