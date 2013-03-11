FactoryGirl.define do
	factory :user do
		name	"John Kucera"
		email	"not@telling.com"
		password "foobar"
		password_confirmation "foobar"
	end
end