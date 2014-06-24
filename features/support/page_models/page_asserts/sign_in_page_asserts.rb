module PageModels
  module SignInPageAsserts

    def assert_reset_password_link
      expect(sign_in_page).to have_send_reset_link
    end

  end
end
World(PageModels::SignInPageAsserts)