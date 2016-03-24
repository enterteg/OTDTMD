class Post < ActiveRecord::Base
	validate :validate_travel_pin
	belongs_to :category
	has_many :photos


	default_scope { order(created_at: :desc)}
	
	scope :travel, -> { where(category_id: 1)}
	scope :food, -> { where(category_id: 2)}
	scope :life, -> { where(category_id: 3)}


	validates_presence_of :title, :desc, :category_id
	validates :desc, length: { minimum: 10}
	validates :title, length: { minimum: 3}

	def validate_travel_pin
		 if (self.category_id == 1 && (self.locX == nil || self.locY == nil))
		 	errors.add(:location, "is not set")  
		 	false
		 end
	end

end
