require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase
  setup do
    @registration = registrations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:registrations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create registration" do
    assert_difference('Registration.count') do
      post :create, registration: { address_city: @registration.address_city, address_country_id: @registration.address_country_id, address_line1: @registration.address_line1, address_line2: @registration.address_line2, address_others: @registration.address_others, address_post_code: @registration.address_post_code, assigned_by: @registration.assigned_by, assigned_to: @registration.assigned_to, country_id: @registration.country_id, course_id: @registration.course_id, created_by: @registration.created_by, date_of_birth: @registration.date_of_birth, email1: @registration.email1, email2: @registration.email2, emer_email: @registration.emer_email, emer_full_name: @registration.emer_full_name, emer_mobile: @registration.emer_mobile, emer_relationship: @registration.emer_relationship, first_name: @registration.first_name, flight_airport: @registration.flight_airport, flight_arrival_date: @registration.flight_arrival_date, flight_arrival_time: @registration.flight_arrival_time, flight_no: @registration.flight_no, gender: @registration.gender, home_phone: @registration.home_phone, mobile1: @registration.mobile1, mobile2: @registration.mobile2, passport_number: @registration.passport_number, proficieny_id: @registration.proficieny_id, qua_exam: @registration.qua_exam, qua_grade: @registration.qua_grade, qua_id: @registration.qua_id, qua_institution: @registration.qua_institution, qua_score: @registration.qua_score, qua_subject: @registration.qua_subject, ref_no: @registration.ref_no, reg_came_through: @registration.reg_came_through, reg_direct: @registration.reg_direct, reg_source_id: @registration.reg_source_id, sub_agent_id: @registration.sub_agent_id, surname: @registration.surname, updated_by: @registration.updated_by, valid_till: @registration.valid_till, valid_till: @registration.valid_till, visa_type: @registration.visa_type, work_phone: @registration.work_phone }
    end

    assert_redirected_to registration_path(assigns(:registration))
  end

  test "should show registration" do
    get :show, id: @registration
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @registration
    assert_response :success
  end

  test "should update registration" do
    put :update, id: @registration, registration: { address_city: @registration.address_city, address_country_id: @registration.address_country_id, address_line1: @registration.address_line1, address_line2: @registration.address_line2, address_others: @registration.address_others, address_post_code: @registration.address_post_code, assigned_by: @registration.assigned_by, assigned_to: @registration.assigned_to, country_id: @registration.country_id, course_id: @registration.course_id, created_by: @registration.created_by, date_of_birth: @registration.date_of_birth, email1: @registration.email1, email2: @registration.email2, emer_email: @registration.emer_email, emer_full_name: @registration.emer_full_name, emer_mobile: @registration.emer_mobile, emer_relationship: @registration.emer_relationship, first_name: @registration.first_name, flight_airport: @registration.flight_airport, flight_arrival_date: @registration.flight_arrival_date, flight_arrival_time: @registration.flight_arrival_time, flight_no: @registration.flight_no, gender: @registration.gender, home_phone: @registration.home_phone, mobile1: @registration.mobile1, mobile2: @registration.mobile2, passport_number: @registration.passport_number, proficieny_id: @registration.proficieny_id, qua_exam: @registration.qua_exam, qua_grade: @registration.qua_grade, qua_id: @registration.qua_id, qua_institution: @registration.qua_institution, qua_score: @registration.qua_score, qua_subject: @registration.qua_subject, ref_no: @registration.ref_no, reg_came_through: @registration.reg_came_through, reg_direct: @registration.reg_direct, reg_source_id: @registration.reg_source_id, sub_agent_id: @registration.sub_agent_id, surname: @registration.surname, updated_by: @registration.updated_by, valid_till: @registration.valid_till, valid_till: @registration.valid_till, visa_type: @registration.visa_type, work_phone: @registration.work_phone }
    assert_redirected_to registration_path(assigns(:registration))
  end

  test "should destroy registration" do
    assert_difference('Registration.count', -1) do
      delete :destroy, id: @registration
    end

    assert_redirected_to registrations_path
  end
end
