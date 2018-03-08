class UsersController < ApplicationController
  attr_reader :searched_users, :search_support

  def index
    @search_support = SearchSupports.new searched_users
    @users = searched_users.result.paginate page: params[:page]
  end
end
