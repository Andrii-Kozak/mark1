FactoryBot.create_list(:user_group, 20, :moderator)
groups = Group.all
users = User.all

admin = FactoryBot.create(:user,
                          first_name: 'Admin',
                          last_name: 'Test',
                          email: "example@railstutorial.org",
                          password: "123123",
                          password_confirmation: "123123",
                          role: 0)

50.times { FactoryBot.create(:post, :with_image, postable: groups.sample, creator: users.sample) }
50.times { FactoryBot.create(:post, :with_image, postable: users.sample, creator: users.sample) }
20.times { FactoryBot.create(:post, :with_image, postable: admin, creator: users.sample) }
