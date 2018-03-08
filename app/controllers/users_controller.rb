class UsersController < ApplicationController
  attr_reader :searched_users, :search_support

  def index
    @search_support = SearchSupports.new searched_users
    redirect_to root_path if search_support.search_value_empty?
    @users = searched_users.result.paginate page: params[:page]
  end
end
