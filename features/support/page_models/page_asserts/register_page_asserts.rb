module PageModels
  module RegisterPageAsserts

    def assert_sign_in_link(email_address)
      expect(register_page.sign_email_link.text).to include(email_address)
    end

    def assert_promotion_checkbox_ticked(expected_state)
      expect(register_page.newsletter_checkbox).to be expected_state
    end

  end
end
World(PageModels::RegisterPageAsserts)