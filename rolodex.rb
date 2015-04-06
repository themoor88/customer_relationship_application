class Rolodex
  def initialize
    @contacts = []
    @id = 0
  end

  def find(contact_id)
    @contacts.find do |contact|
      contact.id == contact_id
    end
  end

  def store_new_contact(contact)
    contact.id = @id
    @contacts << contact
    @id += 1
  end

  def modify_contact(attribute)
    @contacts.map {|c| c.send(attribute)}
  end

  def display_all_contacts
    @contacts
  end

  def delete_contact(contact_id)
    @contacts.delete_if do |contact|
    contact.id == contact_id
    end
  end
end