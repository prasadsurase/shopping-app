FactoryGirl.define do
  factory :credit_card do
    user nil
    encrypted_number "MyString"
    encrpted_cvv "MyString"
    expiry_date "2016-11-28"
  end
end
