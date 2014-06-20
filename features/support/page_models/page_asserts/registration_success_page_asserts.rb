module PageModels
  module RegistrationSuccessAsserts

    def assert_welcome_message
      expect(registration_success_page.welcome_label).to have_content(test_data('messages', 'welcome'), :visible => true)
    end

  end
end
World(PageModels::RegistrationSuccessAsserts)