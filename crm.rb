require_relative 'contact'
require_relative 'rolodex'
require 'faker'

class CRM
  def self.run
    crm = new
    crm.main_menu
  end

  def initialize
    @rolodex = Rolodex.new
    100.times do
      @rolodex.store_new_contact(Contact.new(Faker::Name.first_name, Faker::Name.last_name, Faker::Internet.email, Faker::Hacker.say_something_smart))
    end
  end

  def main_menu
    while true
      print_main_menu
      selection = gets.chomp.to_i
      call_selection(selection)
    end
  end

  def print_main_menu
    puts "[1] Add new contact"
    puts "[2] Modify an existing contact"
    puts "[3] Delete a contact"
    puts "[4] Display a contact"
    puts "[5] Display all of the contacts"
    puts "[6] Display an attribute"
    puts "[7] Exit"
    puts "Enter a selection"
  end

  def call_selection(selection)
    add if selection == 1
    modify if selection ==2
    delete if selection == 3
    display if selection == 4
    display_all if selection == 5
    disply_attribute if selection == 6
    exit if selection == 7
  end

  def add
    print "First name:"
    first_name = gets.chomp
    print "Last name:"
    last_name = gets.chomp
    print "Email:"
    email = gets.chomp
    print "Note:"
    notes = gets.chomp
    contact = Contact.new(first_name, last_name, email, notes)
    @rolodex.store_new_contact(contact)
  end

  def modify
    print "Enter the id of the user you would like to modify:"
    contact_id = gets.chomp.to_i
    contact = @rolodex.find(contact_id)
    puts contact
    puts "Is this the user? Yes or no?"
    answer = gets.chomp.downcase
    if answer == "yes"
      puts "Would you like to change First Name, Last Name, Email or Notes?"
      attribute =  gets.chomp.downcase
      puts "What would you like to change the #{attribute} to?"
      new_attribute = gets.chomp.downcase
      @rolodex.modify_contact(contact, attribute, new_attribute)
      puts "Here is the new contact: #{contact}"
    end
  end

  def delete
    print "Enter the id of the user you would like to delete:"
    contact_id = gets.chomp.to_i
    contact = @rolodex.find(contact_id)
    puts contact
    puts "Is this the user? Yes or no?"
    answer = gets.chomp.downcase
    if answer == "yes"
      @rolodex.delete_contact(contact_id)
      puts "This user has been deleted."
    else answer == "no"
      main_menu
    end
  end

  def display
    print "Enter the id of the user you would like to view:"
    contact_id = gets.chomp.to_i
    contact = @rolodex.find(contact_id)
    puts contact
  end

  def display_all
   puts @rolodex.contacts
  end

  def display_attribute
    print "Enter the id of the user you would like to view:"
    contact_id = gets.chomp.to_i
    contact = @rolodex.find(contact_id)
    puts contact
  end
end

CRM.run