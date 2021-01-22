FactoryBot.create_list(:user, 15)
FactoryBot.create_list(:group, 10)

FactoryBot.create(:user, first_name: 'Admin', last_name: 'Test',
                  email: "example@railstutorial.org",
                  password: "123123",
                  password_confirmation: "123123",
                  role: 0)
