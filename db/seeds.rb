puts "Creating default tags..."

Tag::PROTECTED_TAGS.each do |tag_name|
  Tag.find_or_create_by!(name: tag_name)  
end

puts "Default tags created!"