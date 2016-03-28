module PublicHelper
	def post_cat_name cat_id
		case cat_id
			when 1
				'travels'
			when 2
				'food'
			when 3
				'life'
			when 4
				'about'
		end	
	end
end
