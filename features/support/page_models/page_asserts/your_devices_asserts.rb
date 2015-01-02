module PageModels
  module YourDevicesAsserts
    def assert_no_devices_present
      refresh_current_page
      expect(your_devices_page).to have_no_device_list
    end

    def assert_device_count(device_count)
      expect(your_devices_page.devices.count).to eq(device_count)
    end

    def assert_device_name(name)
      refresh_current_page
      expect(your_devices_page.device_name.text).to eq(name)
    end
  end
end

World(PageModels::YourDevicesAsserts)
