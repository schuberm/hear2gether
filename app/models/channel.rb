class Channel < ActiveRecord::Base
	has_many :listeners, dependent: :destroy, inverse_of: :channel
end
