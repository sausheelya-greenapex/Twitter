class Tweet < ApplicationRecord
	belongs_to :user
	has_many :retweets, dependent: :destroy

end
