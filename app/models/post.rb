class Post < ActiveRecord::Base

	include PgSearch
  	pg_search_scope :search, 
		  					against: [[:title, 'A'],[:desc, 'B']], 
			  				:using => {
			                  :tsearch => {:prefix => true}
			                }


	validate :validate_travel_pin
	belongs_to :category
	has_attachments :photos, maximum: 30


	default_scope { order(created_at: :desc) }
	
	scope :travel, -> { where(category_id: 1).includes(:photo_files)}
	scope :food, -> { where(category_id: 2).includes(:photo_files)}
	scope :life, -> { where(category_id: 3).includes(:photo_files)}


	validates_presence_of :title, :desc, :category_id
	validates :desc, length: { minimum: 10}
	validates :title, length: { minimum: 3}


	def self.paginate_it (params)
		paginate(page: params, per_page: 4).includes(:photo_files)
	end

	def validate_travel_pin
		 if (self.category_id == 1 && (self.locX == nil || self.locY == nil))
		 	errors.add(:location, "is not set")  
		 	false
		 end
	end
	def self.search_suggestions(term)
	  where('LOWER(title) LIKE :term', term: "%#{term.downcase}%")
	end

end
