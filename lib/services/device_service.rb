module DeviceService
    
    def self.new(params)
        Device.create!(
            custodian_id: params[:custodian_id],
            serial_number: params[:serial_number],
            ip_address: params[:ip_address],
            name: params[:name],
            device_type: params[:device_type],
            mac_address: params[:mac_address]
        )
    end

    def self.update_device(params)
        device = Device.find(params[:id])
    
        if device
          device.update(
            serial_number: params[:serial_number],
            ip_address: params[:ip_address],
            name: params[:name],
            device_type: params[:device_type],
            mac_address: params[:mac_address]
          )
        end
    
        device
    end

    def self.fetch_devices
        Device.select(
          "devices.id",
          "devices.serial_number",
          "devices.ip_address",
          "devices.name",
          "devices.device_type",
          "devices.mac_address",
          "CASE WHEN custodians.custodian_type = 'individual' THEN CONCAT(people.firstname, ' ', people.lastname)
          ELSE departments.name END AS custodian_name"
        )
        .joins("LEFT JOIN custodians ON devices.custodian_id = custodians.id")
        .joins("LEFT JOIN people ON custodians.custodian_type_id = people.id AND custodians.custodian_type = 'individual'")
        .joins("LEFT JOIN departments ON custodians.custodian_type_id = departments.id AND custodians.custodian_type = 'department'")
    end

end