module PageModels
  module YourDevicesAsserts

    def assert_no_devices_present
      refresh_current_page
      your_devices_page.should have_no_device_list
    end

    def assert_device_count (device_count)
      your_devices_page.devices.count.should be_eql(device_count)
    end

    def assert_device_name(name)
      refresh_current_page
      your_devices_page.device_name.text.should be_eql(name)
    end

  end
end
World(PageModels::YourDevicesAsserts)