# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#User.create( :email => 'test@example.com', :password => 'testpass', :username => 'Иванов Иван Иваныч')
Admin.create( :email => 'test@example.com', :password => 'testpass', :admin_name => 'Иванов Иван Иваныч')

District.create( :title => 'Заволжский район')
District.create( :title => 'Московский район')
District.create( :title => 'Пролетарский район')
District.create( :title => 'Центральный район')

GlobalPage.create( :title => 'Подробнее о проекте', :permalink => 'about')
GlobalPage.create( :title => 'Для представителей школ', :permalink => 'to_teacher')
