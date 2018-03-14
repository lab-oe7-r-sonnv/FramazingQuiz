class UsersController < ApplicationController
  attr_reader :header, :search_support

  def index
    @search_support = SearchSupports.new header_searched_users
    redirect_to root_path if search_support.search_value_empty?
    @users = header_searched_users.result.paginate page: params[:page]
  end

  private

  def header_searched_users
    header[:searched_users]
  end
end
