class Photo < ActiveRecord::Base
  belongs_to :post
  has_attached_file :photo, :styles => { :medium => "300x300>",:thumb => "200x100#" }
	
  validates_attachment 	:photo, 
						:presence => true,
						:content_type => { :content_type => /\Aphoto\/.*\Z/ },
						:size => { :less_than => 1.megabyte }
end
