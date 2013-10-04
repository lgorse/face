

FactoryGirl.define do
	factory :user do
		name 	"test"
		email	{generate(:email)}
	end
end

FactoryGirl.define do
	sequence :email do |n|
		"tester#{n}@test.com"
	end

end