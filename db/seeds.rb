require 'rubygems'
require 'faker'

Listable.destroy_all
List.destroy_all
Partner.destroy_all
Public.destroy_all
Token.destroy_all
PartnerApp.destroy_all
PartnerSite.destroy_all
Offer.destroy_all
Invitation.destroy_all
Update.destroy_all
Notice.destroy_all
SiteOfPublic.destroy_all
AppOfPublic.destroy_all

def create_listables
	(1..100).each do |i|  
		nu = Listable.new do |n|
			n.name = "name #{i}"
			n.description = "description #{i}"
			n.topic = "topic #{i}"
			#n.html = Lorem::Base.new('paragraphs', 1).output
			n.html = Faker::Lorem.paragraph
			n.save!
		end
	end
end

def create_publics
	(1..10).each do |i|  
		nu = Public.new do |n|
			n.stormpath_id = "public#{i}"
			n.last_login = "#{Time.now}"
			n.save!
		end
		create_lists nu.id
		create_offers nu.id
		create_notices nu.id
		create_updates nu.id
		create_invitations nu.id
		create_public_sites nu.id
		create_public_apps nu.id
	end
end

def create_partners
	(1..10).each do |i|  
		nu = Partner.new do |n|
			n.stormpath_id = "id #{i}"
			n.description = "partner description #{i}"
			n.name = "partner name #{i}"
			n.url = "partner url #{i}"
			n.html = Faker::Lorem.paragraph
			n.save!
		end
		create_partner_apps nu.id
		create_partner_sites nu.id
	end
end

def create_partner_apps  partner_id
	(1..10).each do |i|  
		nu = PartnerApp.new do |n|
			n.partner_id = partner_id
			n.description = "partner #{partner_id} app description #{i}"
			n.name = "partner #{partner_id} app name #{i}"
			n.html = "partner #{partner_id} app html #{i}"
			n.url = "partner #{partner_id} app url #{i}"
			n.save!
		end
	end
end

def create_partner_sites partner_id
	(1..10).each do |i|  
		nu = PartnerSite.new do |n|
			n.partner_id = partner_id
			n.description = "partner #{partner_id} site description #{i}"
			n.name = "partner #{partner_id} site name #{i}"
			n.html = "partner #{partner_id} site html #{i}"
			n.url = "partner #{partner_id} site url #{i}"
			n.save!
		end
	end
end

def create_lists public_id
	(1..25).each do |i|  
		nu = List.new do |n|
			n.public_id =  public_id
		    n.name = "list name #{i}"
		    n.visibility = "Public"
		    n.values = [{'item' => 'item 1', 'rating' => 8 },{'item' => 'item 2', 'rating' => 7 }].to_json
		    n.last_activity =Time.now
		    n.created = Time.now
			n.save!
		end
	end
 end

def create_offers public_id
	(1..25).each do |i|  
		nu = Offer.new do |n|
			n.public_id =  public_id
			n.partner_id = rand(10)
			n.list = "offer list  #{i}"
			n.headline = "offer headline #{i}"
			n.html = "offer html #{i}" 
			n.posted = Time.now 
			n.effective = Time.now
			n.expires = Time.now
			n.save!
		end
	end
end

def create_invitations public_id
	(1..25).each do |i|  
		nu = Invitation.new do |n|
			n.public_id =  public_id
			n.partner_id = rand(10)
			n.list = "invitation list  #{i}"
			n.headline = "invitation headline #{i}"
			n.html = "invitation html #{i}" 
			n.posted = Time.now 
			n.effective = Time.now
			n.expires = Time.now
			n.save!
		end
	end
end

def create_updates public_id
	(1..25).each do |i|  
		nu = Update.new do |n|
			n.public_id =  public_id
			n.partner_id = rand(10)
			n.list = "update list  #{i}"
			n.headline = "update headline #{i}"
			n.html = "update html #{i}" 
			n.posted = Time.now 
			n.effective = Time.now
			n.expires = Time.now
			n.save!
		end
	end
end

def create_notices public_id
	(1..25).each do |i|  
		nu = Notice.new do |n|
			n.public_id =  public_id
			n.headline = "notice headline #{i}"
			n.html = "notice html #{i}"
			n.posted = Time.now 
			n.save!
		end
	end
 end

def create_public_sites public_id
	(1..25).each do |i|  
		nu = SiteOfPublic.new do |n|
			n.public_id =  public_id
			n.partner_site_id = rand 100
			n.save!
		end
	end
 end

def create_public_apps public_id
	(1..25).each do |i|  
		nu = AppOfPublic.new do |n|
			n.public_id =  public_id
			n.partner_app_id = rand 100
			n.save!
		end
	end
 end

create_listables
create_publics
create_partners
