class Photo < ActiveRecord::Base
  belongs_to :post

  scope :three_only, -> {limit(3)}
  has_attached_file :photo, :styles => { :medium => "300x300>",:thumb => "250x180#" }
	
  validates_attachment 	:photo, size: { less_than: 1.megabyte }
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
end
