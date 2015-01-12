module PageModels
  module YourDevicesActions
    def delete_device
      your_devices_page.delete_device.click
      your_devices_page.wait_for_delete_device_pop_up
    end

    def confirm_delete_device
      your_devices_page.delete_device_pop_up.confirm
    end

    def cancel_delete_device
      your_devices_page.delete_device_pop_up.cancel
    end

    def close_delete_device_pop_up
      your_devices_page.delete_device_pop_up.close
    end

    def rename_device(new_name)
      your_devices_page.rename_device.click
      your_devices_page.rename_device_input.set new_name
    end

    def confirm_rename_device
      your_devices_page.confirm_rename_device.click
      your_devices_page.wait_until_device_name_visible
    end

    def cancel_rename_device
      your_devices_page.cancel_rename_device.click
    end
  end
end
World(PageModels::YourDevicesActions)
