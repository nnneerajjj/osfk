require 'test_helper'

class LocationReportsControllerTest < ActionController::TestCase
  setup do
    @location_report = location_reports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:location_reports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create location_report" do
    assert_difference('LocationReport.count') do
      post :create, location_report: { comment: @location_report.comment, latitude: @location_report.latitude, longitude: @location_report.longitude, user_id: @location_report.user_id }
    end

    assert_redirected_to location_report_path(assigns(:location_report))
  end

  test "should show location_report" do
    get :show, id: @location_report
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @location_report
    assert_response :success
  end

  test "should update location_report" do
    patch :update, id: @location_report, location_report: { comment: @location_report.comment, latitude: @location_report.latitude, longitude: @location_report.longitude, user_id: @location_report.user_id }
    assert_redirected_to location_report_path(assigns(:location_report))
  end

  test "should destroy location_report" do
    assert_difference('LocationReport.count', -1) do
      delete :destroy, id: @location_report
    end

    assert_redirected_to location_reports_path
  end
end
