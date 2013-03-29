namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do #ensures this rake has access to the localhost
    admin = User.create!(name: "Example User",
                         email: "exampleadmin@railstutorial.org",
                         password: "foobar",
                         password_confirmation: "foobar")
    admin.toggle!(:admin)

    User.create!(name: "Example User",
                 email: "example@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar")
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password#{n}"
      
      #the ! means that errors will be surfaced instead of hidden
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end