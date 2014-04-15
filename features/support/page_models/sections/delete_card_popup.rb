module PageModels
  class DeleteCardPopup < PageModels::BlinkboxbooksSection
    element :delete_button, 'button'
    element :keep_button, "a[data-test='close-popup']"
  end
end