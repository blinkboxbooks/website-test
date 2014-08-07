module PageModels
  module SignInPageAsserts

    def assert_reset_password_link
      sign_in_page.wait_for_send_reset_link
      sign_in_page.wait_until_send_reset_link_visible
      expect(sign_in_page).to have_send_reset_link
    end

  end
end
World(PageModels::SignInPageAsserts)