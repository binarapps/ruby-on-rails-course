FactoryBot.define do
  factory :user do
    name { 'Gal Anonim' }
    email { "email#{SecureRandom.uuid}@unknowndomain.pl"}
    password { "somepassword"}
  end
end
