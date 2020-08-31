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
  User.find_or_create_by!(email: 'pcasuelas@example.com') do |admin|
    admin.identity_number = '11111111'
    admin.name = 'Pepe Casuelas'
    admin.gender = 1
    admin.birth_date = DateTime.civil_from_format :local, 2001, 01, 01
    admin.password = 'password'
    admin.admin = false
  end

  User.find_or_create_by!(email: 'nuzumaki@example.com') do |admin|
    admin.identity_number = '12345677'
    admin.name = 'Naruto Uzumaki'
    admin.gender = 1
    admin.birth_date = DateTime.civil_from_format :local, 2001, 07, 07
    admin.password = 'password'
    admin.admin = true
  end

  User.find_or_create_by!(email: 'suchiha@example.com') do |admin|
    admin.identity_number = '22222222'
    admin.name = 'Sasuke Uchiha'
    admin.gender = 1
    admin.birth_date = DateTime.civil_from_format :local, 2001, 02, 02
    admin.password = 'password'
    admin.admin = false
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