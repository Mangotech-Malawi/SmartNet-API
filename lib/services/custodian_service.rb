module CustodianService
  def self.new(params)
    Custodian.transaction do
      if params[:custodian_type] == "individual"
        person = create_person(params)
        create_custodian(person, params[:custodian_type]) unless person.blank?
      end
    end
  end

  def self.fetch_custodians
    Custodian.select(
      "custodians.id",
      "people.national_id",
      "people.firstname",
      "people.lastname",
      "people.date_of_birth",
      "people.phone_number",
      "custodians.custodian_type"
    )
    .joins("JOIN people ON custodians.custodian_type_id = people.id AND custodians.custodian_type = 'individual'")
    .where("custodians.voided = ?", false)
  end

  def self.update_custodian(params)
    custodian_id = params[:id]
    custodian = Custodian.find(custodian_id)

    if custodian && custodian.custodian_type == 'individual'
      update_person(custodian.custodian_type_id, params)
      custodian.update(params.slice(:custodian_type))
    end

    custodian
  end

  private

  def self.create_person(params)
    Person.create!(
      national_id: params[:national_id],
      firstname: params[:firstname],
      lastname: params[:lastname],
      gender: params[:gender],
      date_of_birth: params[:date_of_birth],
      phone_number: params[:phone_number]
    )
  end

  def self.create_custodian(custodian_type, type)
    Custodian.create!(
      custodian_type_id: custodian_type.id,
      custodian_type: type
    )
  end

  def self.update_person(id, params)
    person = Person.find(id)
    person.update(params.slice(:firstname, :lastname, :gender, :date_of_birth, :phone_number))
  end
end
