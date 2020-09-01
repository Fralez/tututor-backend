# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
if Rails.env.development?
  User.find_or_create_by!(email: 'admin@example.com') do |admin|
    admin.identity_number = '77777777'
    admin.name = 'Magic Admin'
    admin.gender = 0
    admin.birth_date = DateTime.civil_from_format :local, 2007, 07, 07
    admin.password = 'password'
    admin.admin = true
  end

  # Mock-data users
  User.find_or_create_by!(email: 'pcasuelas@example.com') do |user|
    user.identity_number = '11111111'
    user.name = 'Pepe Casuelas'
    user.gender = 1
    user.birth_date = DateTime.civil_from_format :local, 2001, 01, 01
    user.password = 'password'
    user.admin = false
  end

  User.find_or_create_by!(email: 'nuzumaki@example.com') do |user|
    user.identity_number = '12345677'
    user.name = 'Naruto Uzumaki'
    user.gender = 1
    user.birth_date = DateTime.civil_from_format :local, 2001, 07, 07
    user.password = 'password'
    user.admin = true
  end

  User.find_or_create_by!(email: 'suchiha@example.com') do |user|
    user.identity_number = '22222222'
    user.name = 'Sasuke Uchiha'
    user.gender = 1
    user.birth_date = DateTime.civil_from_format :local, 2001, 02, 02
    user.password = 'password'
    user.admin = false
  end

    # Mock-data institutions
  Institution.find_or_create_by!(email: 'anima@example.com') do |institution|
    institution.name = 'ANIMA - Bachillerato Tecnológico'
    institution.address = "Canelones 1162"
    institution.description = "This is the description of ANIMA"
    institution.creator = User.find_by(email: 'admin@example.com')
  end

  Institution.find_or_create_by!(email: 'fhce@example.com') do |institution|
    institution.name = 'Facultad de Humanidades - Universidad de la República'
    institution.address = "Avenida Uruguay 1695"
    institution.description = "This is the description of FHCE"
    institution.creator = User.find_by(email: 'admin@example.com')
  end

  Institution.find_or_create_by!(email: 'ort@example.com') do |institution|
    institution.name = 'Universidad ORT Uruguay'
    institution.address = "Cuareim 1451"
    institution.description = "This is the description of ORT"
    institution.creator = User.find_by(email: 'admin@example.com')
  end

  User.find_or_create_by!(email: 'animastudent@example.com') do |user|
    user.identity_number = '12121212'
    user.name = 'ANIMA Student'
    user.gender = 2
    user.birth_date = DateTime.civil_from_format :local, 2003, 01, 02
    user.password = 'password'
    user.admin = false
    user.institution_id = Institution.find_by(email: 'anima@example.com').id
  end

  User.find_or_create_by!(email: 'fhcestudent@example.com') do |user|
    user.identity_number = '13131313'
    user.name = 'FHCE Student'
    user.gender = 2
    user.birth_date = DateTime.civil_from_format :local, 2003, 01, 02
    user.password = 'password'
    user.admin = false
    user.institution_id = Institution.find_by(email: 'fhce@example.com').id
  end

  User.find_or_create_by!(email: 'ortstudent@example.com') do |user|
    user.identity_number = '14141414'
    user.name = 'ORT Student'
    user.gender = 2
    user.birth_date = DateTime.civil_from_format :local, 2003, 01, 02
    user.password = 'password'
    user.admin = false
    user.institution_id = Institution.find_by(email: 'ort@example.com').id
  end
end

# Create categories
QuestionCategory.create!(title: "Matemáticas")
QuestionCategory.create!(title: "Ciencias Sociales")
QuestionCategory.create!(title: "Historia")
QuestionCategory.create!(title: "Geografía")
QuestionCategory.create!(title: "Administración")
QuestionCategory.create!(title: "TIC")
QuestionCategory.create!(title: "Biología")
QuestionCategory.create!(title: "Derecho")
QuestionCategory.create!(title: "Lengua")