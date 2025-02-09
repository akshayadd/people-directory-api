class PhoneNumbersController < ApplicationController
  before_action :set_person
  before_action :set_phone_number, only: [:show, :update, :destroy]

  def create
    @phone_number = @person.phone_numbers.build(phone_number_params)
    if @phone_number.save
      render json: @phone_number, status: :created
    else
      render json: @phone_number.errors, status: :unprocessable_entity
    end
  end

  def show; end

  def update
    if @phone_number.update(phone_number_params)
      render json: @phone_number
    else
      render json: @phone_number.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @phone_number.destroy
  end

  private

  def set_person
    @person = Person.find_by(id: params[:people_id])
    render json: {error: 'Unable to find user'}, status: :unprocessable_entity if @person.nil?
  end

  def set_phone_number
    @phone_number = @person.phone_numbers.find(params[:id])
    render json: {error: 'Unable to find this phone number'}, status: :unprocessable_entity if @phone_number.nil?
  end

  def phone_number_params
    params.require(:phone_number).permit(:mobile_number, :is_primary)
  end
end
