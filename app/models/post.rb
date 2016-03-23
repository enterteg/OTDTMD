class Post < ActiveRecord::Base
	belongs_to :category
	has_many :photos

	validates_presence_of :title, :desc, :category_id
	validates :desc, length: { minimum: 10}
	validates :title, length: { minimum: 3}
end
