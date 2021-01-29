FactoryBot.create_list(:user_group, 20, :moderator)

FactoryBot.create(:user, first_name: 'Admin', last_name: 'Test',
                  email: "example@railstutorial.org",
                  password: "123123",
                  password_confirmation: "123123",
                  role: 0)
