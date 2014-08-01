class Listener < ActiveRecord::Base
	belongs_to :channel, inverse_of: :listeners
end
