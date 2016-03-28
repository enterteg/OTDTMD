class Post < ActiveRecord::Base
	searchkick
	
	validate :validate_travel_pin
	belongs_to :category
	has_many :photos, dependent: :destroy



	default_scope { order(created_at: :desc) }
	
	scope :travel, -> { where(category_id: 1).includes(:photos)}
	scope :food, -> { where(category_id: 2).includes(:photos)}
	scope :life, -> { where(category_id: 3).includes(:photos)}


	validates_presence_of :title, :desc, :category_id
	validates :desc, length: { minimum: 10}
	validates :title, length: { minimum: 3}


	def self.paginate_it (params)
		paginate(page: params, per_page: 4).includes(:photos)
	end

	def validate_travel_pin
		 if (self.category_id == 1 && (self.locX == nil || self.locY == nil))
		 	errors.add(:location, "is not set")  
		 	false
		 end
	end

end
