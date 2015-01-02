module PageModels
  class DeleteDevicePopup < PageModels::BlinkboxbooksSection
    element :keep_device, '[data-test="close-popup"]'
    element :remove_device, 'div.buttons button.yellow_button'
    element :close_pop_up, 'section.clearfix span.ng-scope'

    def confirm
      remove_device.click
    end

    def cancel
      keep_device.click
    end

    def close
      close_pop_up.click
    end
  end
end
