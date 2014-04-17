module PageModels
  class DeleteCardPopup < PageModels::BlinkboxbooksSection
    element :delete_button, 'button'
    element :keep_button, "a[data-test='close-popup']"

    def confirm
      delete_button.click
    end
  end
end