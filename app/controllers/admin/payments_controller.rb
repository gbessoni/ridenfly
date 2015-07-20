class Admin::PaymentsController < ApplicationController
  def index
    @payments = Payment.all
  end

  def create
  end
end
