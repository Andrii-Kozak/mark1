module ControllerMacros
  def login_admin
    before do
      @request.env['device.mapping'] = Devise.mappings[:admin]
      sign_in FactoryBot.create(:user, role: 'admin')
    end
  end

  def login_user
    before do
      @request.env['device.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
    end
  end
end
