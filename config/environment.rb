# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Organizor::Application.initialize!


my_datetime_formats = { :default => "%d-%m-%Y %R %p" } 
my_date_formats = { :default => '%d-%m-%Y' } 

Time::DATE_FORMATS.merge!(my_datetime_formats)
Date::DATE_FORMATS.merge!(my_date_formats)


