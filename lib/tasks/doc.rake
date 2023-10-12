# coding: utf-8
require 'rake'
require 'progress_bar'

namespace :doc do
  desc "migrate doc to folder"
  task :migrate_to_folder => :environment do
	School.all.each do |school|
		school.migrate_to_folder
	end
  end

  desc "edit doc link"
  task :edit_doc_link => :environment do
  	PageNavigationLink.find_all_by_title("Документы").each do |link|
		link.link = 'folders'
		link.save
	end
  end

	
	desc "add security group"
	task :add_security_group => :environment do
		PageGroup.transaction do
			bar = ProgressBar.new(School.all.count)
			School.all.each do |school|
				group_attr = {
					:title => 'Информационная безопасность',
					:content_type => 'health',
					:image => File.new('app/assets/images/default/page_group/h_ib.jpg', "r")
				}
				group = PageGroup.where( "lower(title) = 'информационная безопасность' and content_type = 'health' and school_id = ?", school.id ).first
				group ||= PageGroup.new(group_attr)
				group.school = school
				group.default = true
				group.save

				links = group.page_navigation_link.map(&:title)

				group.create_link("Детские безопасные сайты", 'security/detskiye-bezopasnyye-sayty', true) unless links.include?("Детские безопасные сайты")
				group.create_link("Родителям", 'security/roditelyam', true) unless links.include?("Родителям")
				group.create_link("Ученикам", 'security/uchenikam', true) unless links.include?("Ученикам")
				group.create_link("Педагогам", 'security/pedagogam', true) unless links.include?("Педагогам")
				group.create_link("Нормативное регулирование", 'security/normativnoye-regulirovaniye', true) unless links.include?("Нормативное регулирование")
				group.create_static_page("Локальные акты", true) unless links.include?("Локальные акты")
				bar.increment!
			end
		end
	end

	desc "move food group to about"
	task :move_food_group => :environment do
		PageGroup.transaction do
			bar = ProgressBar.new(School.all.count)
			School.all.each do |school|
				group_attr = {
					:title => 'Организация питания в образовательной организации',
					:content_type => 'about',
					:image => File.new('app/assets/images/default/page_group/h_op.jpg', "r")
				}
				find_group = ['питание', 'организация питания', 'организация питания в школьной столовой', 'организация питания в образовательной организации']
				group = PageGroup.where( "lower(title) in (?) and school_id = ?", find_group, school.id ).first
				group ||= PageGroup.new(group_attr)
				group.title = 'Организация питания в образовательной организации'
				group.content_type = 'about'
				group.school = school
				group.default = true
				group.save

				links = group.page_navigation_link.map(&:title)

				bar.increment!
			end
		end
	end

end
