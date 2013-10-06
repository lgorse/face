

FactoryGirl.define do
	factory :user do
		name 	"test"
		email	{generate(:email)}
		password	"Supercool"
	end
end

FactoryGirl.define do
	sequence :email do |n|
		"tester#{n}@test.com"
	end
end

FactoryGirl.define do
	factory :post do
		association		:user
		text			"random"
	end

end